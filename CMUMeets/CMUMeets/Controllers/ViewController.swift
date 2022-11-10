//
//  ViewController.swift
//  FindMyCar
//
//  Created by Ricky Lee on 11/3/22.
//  Copyright © 2022 Steph K. Ananth. All rights reserved.
//

import Foundation
import FirebaseFirestore

class ViewController: ObservableObject {
    let currentLocation = Location()
    @Published var locations: [Dictionary<String, Any>] = []
    @Published var meets: [Dictionary<String, Any>] = []
  
//  func unwrap() {
//
//  }
  
//
//  func show() {
//    for (key, value) in self.locations {
//      print(key)
//    }
//  }
//
  
  func test() -> Int {
     
//    for (key, value) in self.locations[0] {
//       print("(\(key),\(value))")
//    }
    return self.locations.count
  }
    func readLocations() -> String {
        var db = Firestore.firestore()
        
        db.collection("locations").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                  self.locations.append(document.data())
                }
            }
        }
      return "success: locations"
    }
  
  func readMeets() -> String {
    var db = Firestore.firestore()
    
    db.collection("meets").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
//          print("\(document.documentID) => \(document.data())")
//          print(type(of: document.data()))
          self.meets.append(document.data())
        }
      }
    }
    return "success: meets"
  }
  
  func updatedMeets() -> String {
    var db = Firestore.firestore()

    db.collection("meets")
        .addSnapshotListener { querySnapshot, error in
//          guard let snapshot = querySnapshot else {
//              print("Error fetching snapshots: \(error!)")
//              return
//          }
          guard let snapshot = querySnapshot else {
              print("Error fetching snapshots: \(error!)")
              return
          }
          snapshot.documentChanges.forEach { diff in
              if (diff.type == .added) {
                  print("New meet: \(diff.document.data())")
              }
              if (diff.type == .modified) {
                  print("Modified meet: \(diff.document.data())")
              }
//              if (diff.type == .removed) {
//                  print("Removed meet: \(diff.document.data())")
//              }
          }
          // redraw map
        }
    return "success: updates"
  }
  
  func test2() -> String {
    var db = Firestore.firestore()
    db.collection("meets").document("VHLcprR8LzYYgsTairir")
        .addSnapshotListener { documentSnapshot, error in
          guard let document = documentSnapshot else {
            print("Error fetching document: \(error!)")
            return
          }
          guard let data = document.data() else {
            print("Document data was empty.")
            return
          }
          print("Current data: \(data)")
        }
    return "test2 passed"
  }


}
