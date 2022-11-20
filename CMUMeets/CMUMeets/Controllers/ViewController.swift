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
