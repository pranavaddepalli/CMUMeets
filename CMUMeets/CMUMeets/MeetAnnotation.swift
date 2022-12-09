//
//  MeetAnnotations.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/17/22.
//

import Foundation
import UIKit
import MapKit
import FirebaseFirestore

class MeetAnnotation:NSObject,MKAnnotation,Identifiable{
  let id = UUID()
  var coordinate: CLLocationCoordinate2D
  var title: String?
  var subtitle: String?
  var meet: Meet
  var firebase: Firebase
  init(meet: Meet, firebase: Firebase){
    self.coordinate = CLLocationCoordinate2D(latitude: meet.latitude, longitude: meet.longitude)
    self.title = meet.title
    self.subtitle = meet.location
    self.meet = meet
    self.firebase = firebase
  }
}
