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
  @ObservedObject var viewController: ViewController
  
  func isSameDay(date1: Date, date2: Date) -> Bool {
      let diff = Calendar.current.dateComponents([.day], from: date1, to: date2)
      if diff.day == 0 {
          return true
      } else {
          return false
      }
  }
  
  // think about how to remove meets from map
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    print("updating view")
    if viewController.locations.count > 0 && viewController.meets.count > 0  {
        uiView.removeAnnotations(uiView.annotations)
      
      for (_, meet) in viewController.meets{
        let date = (meet["endTime"] as! Timestamp).dateValue()

        if isSameDay(date1: date, date2: Date.now) && date > Date.now {
          let droppedPin = MKPointAnnotation()
          droppedPin.coordinate = CLLocationCoordinate2D(
            latitude: meet["latitude"] as! Double,
            longitude: meet["longitude"] as! Double
          )
          droppedPin.title = meet["title"] as! String
          droppedPin.subtitle = meet["location"] as! String
          uiView.addAnnotation(droppedPin)
        }
      }
    }
  }

  func makeUIView(context: Context) -> MKMapView {
    //viewController.readMeets()
    viewController.readLocations()
    viewController.readMeets()
    viewController.updatedMeets()
    

//    let currLoc = Location()
//    currLoc.getCurrentLocation()
    
//    let pin = Location()
//    pin.loadLocation()
//    let loc1 = viewController.locations[0]
//    let droppedPin = MKPointAnnotation()
//    droppedPin.coordinate = CLLocationCoordinate2D(
//        latitude: loc1["latitude"] as! Double,
//        longitude: loc1["longitude"] as! Double
//    )
//    droppedPin.title = "You are Here"
//    droppedPin.subtitle = "Look it's you!"
    let mapView = MKMapView(frame: .zero)
//    mapView.addAnnotation(droppedPin)
    mapView.showsUserLocation=true
    let location = Location()
    location.getCurrentLocation()
    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    mapView.setRegion(region, animated: true)
    return mapView
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
      MapView(viewController: ViewController())
    }
}
