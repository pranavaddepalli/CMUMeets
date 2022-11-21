////
////  Firebase.swift
////  ChiMeetLocations
////
////  Created by Steven Lipton on 11/3/17.
////  Copyright © 2017 Steven Lipton. All rights reserved.
////
//
//import UIKit
//import MapKit
//
//

import Foundation
import FirebaseFirestore

class Firebase: ObservableObject {
    let currentLocation = Location()
    @Published var locations: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
    @Published var meets: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
    @Published var users: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
    
    @Published var currentUser: User = User(id: "0", name: "", phone: "", major: "", gradYear: "", age: "", gender: "", pronouns: "", ethnicity: "", username: "")
    
    @Published var ongoingMeets: [Meet] = []
    
    init() {
        
    }
  
  func test() -> Int {
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
                  self.locations[document.documentID] = document.data()
                }
            }
        }
      return "success: locations"
    }
  
    func readUsers() -> String {
        var db = Firestore.firestore()
        
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                  self.users[document.documentID] = document.data()
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
          self.meets[document.documentID] = document.data()
        }
      }
    }
    return "success: meets"
  }
  
  func updatedMeets() -> String {
    var db = Firestore.firestore()
    db.collection("meets")
        .addSnapshotListener { querySnapshot, error in
          guard let snapshot = querySnapshot else {
              print("Error fetching snapshots: \(error!)")
              return
          }
          snapshot.documentChanges.forEach { diff in
              if (diff.type == .added) {
                print("New meet: \(diff.document.data())")
                // Create pin for meet
                self.meets[diff.document.documentID] = diff.document.data()
              }
              if (diff.type == .modified) {
                print("Modified meet: \(diff.document.data())")
                // Rerender this pin?

                self.meets[diff.document.documentID] = diff.document.data()

                
              }
//              if (diff.type == .removed) {
//                  print("Removed meet: \(diff.document.data())")
//              }
          }
          // redraw map
        }
    return "success: updates"
  }
  
}
