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
  
  struct Location {
    let name : String
    let title : String
    let latitude : Float
    let longitude : Float
  }
  
  enum MeetIcon: String, CaseIterable, Identifiable {
      case food, sport, hangout
      var id: Self { self }
  }
  
  
  func getLocationNames() -> [String] {
    var result = [String]()
    
    db.collection("locations").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting location documents: \(err)")
        } else {
          result = querySnapshot!.documents.map { $0.data()["name"] as! String }
//          print(result)
        }
    }
    print(result)
    return result
  }
  
  // MARK: Methods
  func hostMeet() -> String {
    db.collection("meets").document().setData([
      "title" : "Tennis",
      "capacity" : 2,
      "timeStart" : Date(),
      "timeEnd" : Date().advanced(by: 3600), // 1 hour later
      "location" : "The Cut"
    ])
    
    return "Success"
  }
  
  
}
