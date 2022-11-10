//
//  HostViewModel.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import Foundation
import FirebaseFirestore

class HostViewModel : ObservableObject {
  let db = Firestore.firestore()
  let l = LocationSetup()
  
  enum MeetIcon: String, CaseIterable, Identifiable {
      case food, sport, hangout
      var id: Self { self }
  }
  
  func meetIconToText(mi : MeetIcon) -> String {
    switch mi {
    case .food:
      return "🍽"
    case .sport:
      return "⛹️"
    case .hangout:
      return "🎪"
    }
  }
  
  
  func getLocations() -> [LocationSetup.Location] {
    return l.locs
  }
  
  func getDefaultLoc() -> LocationSetup.Location {
    // currently set to The Fence
    return l.locs.first(where: {$0.code == "FENCE"})!
  }
  
  
  
  func hostMeet(meetName : String, icon : MeetIcon, capacity : Int, loc : LocationSetup.Location, start : Date, end : Date) {
    db.collection("meets").document().setData([
      "title" : meetName,
      "icon" : meetIconToText(mi: icon),
      "capacity" : capacity,
      "location" : loc.title,
      "latitude" : loc.latitude,
      "longitude" : loc.longitude,
      "startTime" : start,
      "endTime" : end
    ]) { err in
      if let err = err {
        print("Error writing meet: \(err)")
      } else {
        print("Meet successfully written!")
      }
    }
  }
  
  
}
