//
//  Firebase.swift
//  FindMyCar
//
//  Created by Ricky Lee on 11/3/22.
//  Copyright © 2022 Steph K. Ananth. All rights reserved.
//

import Foundation
import FirebaseFirestore

class Firebase: ObservableObject {
  let currentLocation = Location()
  @Published var locations: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
  @Published var meets: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
  let db = Firestore.firestore()

  func readLocations() -> String {
    self.db.collection("locations").getDocuments() { (querySnapshot, err) in
          if let err = err {
              print("Error getting documents: \(err)")
          } else {
              for document in querySnapshot!.documents {
                self.locations[document.documentID] = document.data()
              }
          }
      }
    return "success: locations"
  }

  func readMeets() -> String {
    self.db.collection("meets").getDocuments() { (querySnapshot, err) in
      if let err = err {
        print("Error getting documents: \(err)")
      } else {
        for document in querySnapshot!.documents {
          self.meets[document.documentID] = document.data()
        }
      }
    }
    return "success: meets"
  }

  func updatedMeets() -> String {
    self.db.collection("meets")
        .addSnapshotListener { querySnapshot, error in
          guard let snapshot = querySnapshot else {
              print("Error fetching snapshots: \(error!)")
              return
          }
          snapshot.documentChanges.forEach { diff in
              if (diff.type == .added) {
                print("New meet: \(diff.document.data())")
                self.meets[diff.document.documentID] = diff.document.data()
              }
              if (diff.type == .modified) {
                print("Modified meet: \(diff.document.data())")
                self.meets[diff.document.documentID] = diff.document.data()
              }
          }
        }
    return "success: updates"
  }
}

