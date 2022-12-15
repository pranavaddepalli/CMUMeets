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
      
    // add a user tracking button
    let userTrackingButton = MKUserTrackingButton(mapView: mapView)
    userTrackingButton.frame = CGRect(x: 10, y: 10, width: 44, height: 44)
    userTrackingButton.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
    userTrackingButton.layer.borderColor = UIColor.white.cgColor
    userTrackingButton.layer.borderWidth = 1
    userTrackingButton.layer.cornerRadius = 5
    mapView.addSubview(userTrackingButton)
    
    mapView.userTrackingMode = .follow

    
    return mapView
  }
  
  private func loadFirebase() {
    firebase.updatedMeets()
    firebase.updatedLocations() {_ in }
    firebase.updatedUsers()
  }
  
  private func setupRegionForMap() {
    mapView.showsUserLocation=true
    mapView.register(MeetAnnotationView.self, forAnnotationViewWithReuseIdentifier: "meet")
    let location = Location()
    location.getCurrentLocation()
    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
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

