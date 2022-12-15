//
//  MapView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/8/22.
//

import SwiftUI
import MapKit
import FirebaseFirestore

extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

struct MapView: UIViewRepresentable {
  
  typealias UIViewType = MKMapView
  let mapView = MKMapView(frame: .zero)
  var firebase: Firebase
  
  class Coordinator: NSObject, MKMapViewDelegate {
//      func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
//          if mapView.region.span.latitudeDelta < 0.4 {
//              let location = Location()
//              location.getCurrentLocation()
//              let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
//              let regionSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//              let mapRegion = MKCoordinateRegion(center: coordinate, span: regionSpan)
//              mapView.setRegion(mapRegion, animated: true)
//          }
//      }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//      mapView.register(MeetAnnotationView.self, forAnnotationViewWithReuseIdentifier: MeetAnnotationView.reuseID)
      guard !(annotation is MKUserLocation) else {
          return nil
      }
      
      if (annotation is MeetAnnotation) {
        var annotation = annotation as! MeetAnnotation
        var annotationView = MeetAnnotationView()

        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: MeetAnnotationView.reuseID) as? MeetAnnotationView {
          annotationView = dequedView
        } else {
          annotationView = MeetAnnotationView(annotation: annotation, reuseIdentifier: MeetAnnotationView.reuseID)
        }
//
//        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MeetAnnotationView.reuseID, for: annotation)
//
        
//        print(type(of: annotationView))
//        if let annotationView = annotationView as MeetAnnotationView {
//          annotationView.glyphText = annotation.meet.icon
//        }
        annotationView.glyphText = annotation.meet.icon
        annotationView.clusteringIdentifier = "meet"
        annotationView.markerTintColor = UIColor.white
        annotationView.subtitleVisibility = .visible
        
        return annotationView
      }
      else {
        // now, annotation is a MKClusterAnnotation
//        let clusterID = "Cluster"
        var clusterView = ClusterView()
        if let dequedView = mapView.dequeueReusableAnnotationView(withIdentifier: ClusterView.reuseID) as? ClusterView {
          clusterView = dequedView
        } else {
          clusterView = ClusterView(annotation: annotation, reuseIdentifier: MeetAnnotationView.reuseID)
        }
        
//        var clusterView = mapView.dequeueReusableAnnotationView(withIdentifier: ClusterView.reuseID)
//        if clusterView == nil {
//          clusterView = ClusterView(annotation: annotation, reuseIdentifier: ClusterView.reuseID)
//        } else {
//            clusterView?.annotation = annotation
//        }
        clusterView.displayPriority = .required
        clusterView.collisionMode = .circle
        clusterView.markerTintColor = .purple
        return clusterView
        
      }
    }
  }
  
  func makeCoordinator() -> Coordinator {
      return Coordinator()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    loadFirebase()
    setupRegionForMap()
    mapView.delegate = context.coordinator
    
//    mapView.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: ClusterView.reuseID)
    
    mapView.showsCompass = false  // Hide built-in compass

    let compassButton = MKCompassButton(mapView: mapView)   // Make a new compass
    compassButton.compassVisibility = .visible          // Make it visible

    mapView.addSubview(compassButton) // Add it to the view

    // Position it as required
    compassButton.translatesAutoresizingMaskIntoConstraints = false
    compassButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -12).isActive = true
    compassButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 12).isActive = true

    return mapView
  }
  
  private func loadFirebase() {
    firebase.updatedMeets()
    firebase.updatedLocations()
    firebase.updatedUsers()
  }
  
  private func setupRegionForMap() {
    mapView.showsUserLocation=true
    mapView.register(MeetAnnotationView.self, forAnnotationViewWithReuseIdentifier: "meet")
    let location = Location()
    location.getCurrentLocation()
    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
  }
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    if firebase.meets.count > 0  {
      uiView.removeAnnotations(uiView.annotations)
      
      for (_, meet) in firebase.meets{
        let date = (meet.endTime).dateValue()

        if isSameDay(date1: date, date2: Date.now) && date > Date.now {
          let droppedPin = MeetAnnotation(meet:meet, firebase: firebase)
          uiView.addAnnotation(droppedPin)
        }
      }
    }
  }
  
  private func isSameDay(date1: Date, date2: Date) -> Bool {
    let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
    return diff.day == 0
  }
}

