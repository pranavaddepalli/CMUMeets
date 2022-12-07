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
//  @Published var locations: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
  @Published var locations: [String: LocationModel] = [String: LocationModel]()
  @Published var meets: [String: Meet] = [String: Meet]()
  @Published var users: [String: Dictionary<String, Any>] = [String: Dictionary<String, Any>]()
  // make into a list of Meet models, User models, Location models
  
  @Published var currentUser: User = User(id: "0", name: "", phone: "", major: "", gradYear: "", age: "", gender: "", pronouns: "", ethnicity: "", username: "")
  
  @Published var ongoingMeets: [Meet] = []
  let db = Firestore.firestore()
  
  init() {
      
  }

  func readUsers() -> String {
      
    self.db.collection("users").getDocuments() { (querySnapshot, err) in
          if let err = err {
              print("Error getting documents: \(err)")
          } else {
              for document in querySnapshot!.documents {
//                    print("\(document.documentID) => \(document.data())")
                self.users[document.documentID] = document.data()
              }
          }
      }
    return "success: users"
  }

  func readLocations() -> String {
    self.db.collection("locations").getDocuments() { (querySnapshot, err) in
          if let err = err {
              print("Error getting documents: \(err)")
          } else {
              for d in querySnapshot!.documents {
//                self.locations[document.documentID] = document.data()
                self.locations[d.documentID] = (
                  LocationModel(
                    code: d["code"] as? String ?? "",
                    latitude: Float((d["latitude"]! as! NSNumber)),
                    longitude: Float((d["longitude"]! as! NSNumber)),
                    name: d["name"] as? String ?? ""

                  )
                )
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
        for d in querySnapshot!.documents {
//          self.meets[document.documentID] = document.data()
          self.meets[d.documentID] = (
            Meet(
              id: d.documentID,
              title: d["title"] as? String ?? "",
              location: d["location"] as? String ?? "",
              startTime: d["startTime"] as? Timestamp ?? Timestamp(),
              endTime: d["endTime"] as? Timestamp ?? Timestamp(),
              joined: d["joined"] as? Int ?? 0,
              capacity: d["capacity"] as? Int ?? 0,
              icon: d["icon"] as? String ?? "",
              latitude: Float((d["latitude"]! as! NSNumber)),
              longitude: Float((d["longitude"]! as! NSNumber)),
              host: d["host"] as? String ?? "",
              people: d["people"] as? [String] ?? [""]
            )
          )
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
                self.meets[diff.document.documentID] = (
                  Meet(
                    id: diff.document.documentID,
                    title: diff.document["title"] as? String ?? "",
                    location: diff.document["location"] as? String ?? "",
                    startTime: diff.document["startTime"] as? Timestamp ?? Timestamp(),
                    endTime: diff.document["endTime"] as? Timestamp ?? Timestamp(),
                    joined: diff.document["joined"] as? Int ?? 0,
                    capacity: diff.document["capacity"] as? Int ?? 0,
                    icon: diff.document["icon"] as? String ?? "",
                    latitude: Float((diff.document["latitude"]! as! NSNumber)),
                    longitude: Float((diff.document["longitude"]! as! NSNumber)),
                    host: diff.document["host"] as? String ?? "",
                    people: diff.document["people"] as? [String] ?? [""]

                  )
                )
              }
              if (diff.type == .modified) {
                print("Modified meet: \(diff.document.data())")
                self.meets[diff.document.documentID] = (
                  Meet(
                    id: diff.document.documentID,
                    title: diff.document["title"] as? String ?? "",
                    location: diff.document["location"] as? String ?? "",
                    startTime: diff.document["startTime"] as? Timestamp ?? Timestamp(),
                    endTime: diff.document["endTime"] as? Timestamp ?? Timestamp(),
                    joined: diff.document["joined"] as? Int ?? 0,
                    capacity: diff.document["capacity"] as? Int ?? 0,
                    icon: diff.document["icon"] as? String ?? "",
                    latitude: Float((diff.document["latitude"]! as! NSNumber)),
                    longitude: Float((diff.document["longitude"]! as! NSNumber)),
                    host: diff.document["host"] as? String ?? "",
                    people: diff.document["people"] as? [String] ?? [""]

                  )
                )
              }
          }
        }
    return "success: updated meets"
  }
  
  func updatedUsers() -> String {
    self.db.collection("users")
        .addSnapshotListener { querySnapshot, error in
          guard let snapshot = querySnapshot else {
              print("Error fetching snapshots: \(error!)")
              return
          }
          snapshot.documentChanges.forEach { diff in
              if (diff.type == .added) {
                print("New user: \(diff.document.data())")
                self.users[diff.document.documentID] = diff.document.data()
              }
              if (diff.type == .modified) {
                print("Modified user: \(diff.document.data())")
                self.users[diff.document.documentID] = diff.document.data()
              }
          }
        }
    return "success: updated users"
  }

  func updatedLocations() -> String {
    self.db.collection("locations")
        .addSnapshotListener { querySnapshot, error in
          guard let snapshot = querySnapshot else {
              print("Error fetching snapshots: \(error!)")
              return
          }
          snapshot.documentChanges.forEach { diff in
              if (diff.type == .added) {
                print("New location: \(diff.document.data())")
                print("AT \(type(of: (diff.document["longitude"]! as! NSNumber)))")
                print("AND \( Float(diff.document["latitude"]! as! NSNumber) )")
                
                self.locations[diff.document.documentID] = (
                  LocationModel(
                    code: diff.document["code"] as? String ?? "",
                    latitude: Float((diff.document["latitude"]! as! NSNumber)),
                    longitude: Float((diff.document["longitude"]! as! NSNumber)),
                    name: diff.document["name"] as? String ?? ""

                  )
                )
              }
              if (diff.type == .modified) {
                print("Modified location: \(diff.document.data())")
                self.locations[diff.document.documentID] = (
                  LocationModel(
                    code: diff.document["code"] as? String ?? "",
                    latitude: Float((diff.document["latitude"]! as! NSNumber)),
                    longitude: Float((diff.document["longitude"]! as! NSNumber)),
                    name: diff.document["String"] as? String ?? ""

                  )
                )
              }
          }
        }
    return "success: updated locations"
  }
  
  
  
  // MARK: Meet operations
  
  // hosting a meet
  func hostMeet(meetName : String, icon : String, capacity : Int, loc : LocationModel, start : Date, end : Date) -> String {
      
    // MARK: validation
    // start date must come before end date
    if (start >= end) {
      return "End time must be after start time."
    }
    
    // capacity has to be greater than 1
    if (capacity <= 1) {
      return "You can't Meet with less than 2 people!"
    }
  
    // title cannot be empty
    if (loc.name == "") {
      return "Give your Meet a good name."
    }
    
    var res = "Successfully hosted your Meet!"
    
    print("HOSTING MEET AT")
    print(loc)
    
    db.collection("meets").document().setData([
      "title" : meetName,
      "icon" : icon,
      "joined" : 1,
      "host" : currentUser.id!,
      "capacity" : capacity,
      "location" : loc.name,
      "latitude" : loc.latitude,
      "longitude" : loc.longitude,
      "startTime" : start,
      "endTime" : end,
      "people" : [currentUser.id!]
    ]) { err in
      if let err = err {
        res = "\(err)"
        print("Error writing meet: \(err)")
      } else {
        print("Meet successfully written!")
      }
    }
    print(res)
    return res;
  }

}

