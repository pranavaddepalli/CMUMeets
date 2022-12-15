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
  
  @Published var joinedMeets: [Meet] = []
  let db = Firestore.firestore()
  
  init() {
      
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
                    latitude: Double((diff.document["latitude"]! as! NSNumber)),
                    longitude: Double((diff.document["longitude"]! as! NSNumber)),
                    host: diff.document["host"] as? String ?? "",
                    people: diff.document["people"] as? [String] ?? [""]

                  )
                )
              }
              if (diff.type == .modified) {
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
                    latitude: Double((diff.document["latitude"]! as! NSNumber)),
                    longitude: Double((diff.document["longitude"]! as! NSNumber)),
                    host: diff.document["host"] as? String ?? "",
                    people: diff.document["people"] as? [String] ?? [""]

                  )
                )
              }
              if (diff.type == .removed) {
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
                    latitude: 0,
                    longitude: 0,
                    host: diff.document["host"] as? String ?? "",
                    people: diff.document["people"] as? [String] ?? [""]
                  )
                )
                  
                  self.joinedMeets.removeAll(where: {$0 == self.meets[diff.document.documentID]})
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
                self.users[diff.document.documentID] = diff.document.data()
              }
              if (diff.type == .modified) {
                self.users[diff.document.documentID] = diff.document.data()
              }
          }
        }
    return "success: updated users"
  }

func updatedLocations(completion: @escaping ([LocationModel]) -> Void) -> String {
    var updatedModels = [LocationModel]()

    self.db.collection("locations")
        .addSnapshotListener { querySnapshot, error in
          guard let snapshot = querySnapshot else {
              print("Error fetching snapshots: \(error!)")
              return
          }
          snapshot.documentChanges.forEach { diff in
              if (diff.type == .added) {
                self.locations[diff.document.documentID] = (
                  LocationModel(
                    code: diff.document["code"] as? String ?? "",
                    latitude: Double((diff.document["latitude"]! as! NSNumber)),
                    longitude: Double((diff.document["longitude"]! as! NSNumber)),
                    name: diff.document["name"] as? String ?? ""

                  )
                )
                updatedModels.append(self.locations[diff.document.documentID]!)
              }
              if (diff.type == .modified) {
                self.locations[diff.document.documentID] = (
                  LocationModel(
                    code: diff.document["code"] as? String ?? "",
                    latitude: Double((diff.document["latitude"]! as! NSNumber)),
                    longitude: Double((diff.document["longitude"]! as! NSNumber)),
                    name: diff.document["String"] as? String ?? ""

                  )
                )
                updatedModels.append(self.locations[diff.document.documentID]!)
              }
          }

          completion(updatedModels)
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
    if (meetName == "") {
      return "Give your Meet a good name."
    }
    
    // cannot be in more than one Meet at a time, so can't host if in a current meet
    for j in self.joinedMeets {
      if j.endTime.dateValue() > Date() {
        return "You can't host a Meet if you are currently in one!"
      }
    }
    
    var res = "Successfully hosted your Meet!"
    
    let newMeetRef = db.collection("meets").document()
          
    newMeetRef.setData([
      "title" : meetName,
      "icon" : icon,
      "joined" : 0,
      "host" : currentUser.id!,
      "capacity" : capacity,
      "location" : loc.name,
      "latitude" : loc.latitude,
      "longitude" : loc.longitude,
      "startTime" : start,
      "endTime" : end,
      "people" : []
    ]) { _ in }
      
      newMeetRef.getDocument(as: Meet.self) { result in
          switch result {
          case .success(let m):
              self.joinMeet(meet: m)
          case.failure(let fail):
              print(fail)
          }
      }
    
    return res;
  }
  
  func joinMeet(meet : Meet) -> String {
    
    // cannot be in more than one Meet at a time, so can't join if in a current meet
    for j in self.joinedMeets {
      if j.endTime.dateValue() > Date() {
        print("Trying to join Meet but already in one")
        return "Trying to join Meet but already in one";
      }
    }
    
      
      db.collection("meets").document(meet.id!).updateData([
          "joined" : meet.joined + 1,
          "people" : FieldValue.arrayUnion([self.currentUser.id!])
      ]) { _ in }
    self.joinedMeets.append(meet)
      return "Successfully joined meet!"
  }
    
    func leaveMeet(meet : Meet) -> String {
        // leave a meet
        var res = "Meet successfully left!"
        db.collection("meets").document(meet.id!).updateData([
            "joined" : meet.joined - 1,
            "people" : FieldValue.arrayRemove([self.currentUser.id!])
        ]) { _ in }
        self.joinedMeets.removeAll(where: {$0.id == meet.id})
        
        return res
    }
    
    func deleteMeet(meet: Meet) -> String {
        var res = "Meet successfully removed!"
        db.collection("meets").document(meet.id!).delete() { _ in }
        self.joinedMeets.removeAll(where: {$0.id == meet.id!})
        // pull Meets again
        self.meets.removeValue(forKey: meet.id!)
      
        return res
            
    }

}

