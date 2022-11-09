//
//  MapView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/8/22.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  let viewController: ViewController
  
  func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
    let location = Location()
    location.getCurrentLocation()
    let coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude
    )
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let region = MKCoordinateRegion(center: coordinate, span: span)
    uiView.setRegion(region, animated: true)
  }

// pin here is red, not blue
  func makeUIView(context: Context) -> MKMapView {
    let currLoc = Location()
    currLoc.loadLocation()
    let droppedPin = MKPointAnnotation()
    droppedPin.coordinate = CLLocationCoordinate2D(
        latitude: currLoc.latitude,
        longitude: currLoc.longitude
    )
    droppedPin.title = "You are Here"
    droppedPin.subtitle = "Look it's you!"
    let mapView = MKMapView(frame: .zero)
    mapView.addAnnotation(droppedPin)
    mapView.showsUserLocation=true
    return mapView
      
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
      MapView(viewController: ViewController())
    }
}
