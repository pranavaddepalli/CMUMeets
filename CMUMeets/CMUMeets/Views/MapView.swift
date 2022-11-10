//
//  MapView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/8/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  @ObservedObject var viewController: ViewController
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    let location = Location()
    location.getCurrentLocation()
    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude
    )
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
    
    if viewController.locations.count > 0 && viewController.meets.count > 0  {
      for meet in viewController.meets{
        var meet_location = meet["location"] as! String
        for location in viewController.locations{
          var location_name = location["name"] as! String
          if meet_location == location_name{
            let droppedPin = MKPointAnnotation()
            droppedPin.coordinate = CLLocationCoordinate2D(
                latitude: location["latitude"] as! Double,
                longitude: location["longitude"] as! Double
            )
            droppedPin.title = meet["title"] as! String
            droppedPin.subtitle = meet["location"] as! String
            uiView.addAnnotation(droppedPin)
          }
        }
      }
      
    }

  }

// pin here is red, not blue
  func makeUIView(context: Context) -> MKMapView {
    //viewController.readMeets()
    viewController.readLocations()
    viewController.readMeets()
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
    return mapView
      
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
      MapView(viewController: ViewController())
    }
}
