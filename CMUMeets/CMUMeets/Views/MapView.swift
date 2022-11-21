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
          var annotationView = MeetAnnotationView()
          guard let annotation = annotation as? MeetAnnotation else {return nil}
          let identifier = ""
          var color = UIColor.white
          var glyphText = ""
          switch annotation.type{
          case "🍽":
              glyphText = "🍽"
          case "⛹️":
              glyphText = "⛹️"
          case "🎪":
              glyphText = "🎪"
          default:
              print("Doesn't match predefined meet categories.")
          }
          if let dequedView = mapView.dequeueReusableAnnotationView(
              withIdentifier: identifier)
              as? MeetAnnotationView {
              annotationView = dequedView
          } else{
              annotationView = MeetAnnotationView(annotation: annotation, reuseIdentifier: identifier)
          }
          annotationView.markerTintColor = UIColor.white
          annotationView.glyphText = glyphText
          annotationView.clusteringIdentifier = identifier
          annotationView.canShowCallout = true
          annotationView.subtitleVisibility = .visible
        
          return annotationView
      }
  }
  
  
  
  
  func makeCoordinator() -> Coordinator {
      return Coordinator()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    loadFirebase()
    setupRegionForMap()
    mapView.delegate = context.coordinator
    return mapView
  }
  
  private func loadFirebase() {
    firebase.readLocations()
    firebase.readMeets()
    firebase.readUsers()
    firebase.updatedMeets()
  }
  
  private func setupRegionForMap() {
    mapView.showsUserLocation=true
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
        let date = (meet["endTime"] as! Timestamp).dateValue()

        if isSameDay(date1: date, date2: Date.now) && date > Date.now {
          let droppedPin = MeetAnnotation(meet:meet)
          uiView.addAnnotation(droppedPin)
        }
      }
    }
  }
  
  private func isSameDay(date1: Date, date2: Date) -> Bool {
    let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
    if diff.day == 0 {
      return true
    } else {
      return false
    }
  }
}


