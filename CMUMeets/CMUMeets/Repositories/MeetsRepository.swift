//
//  MeetsRepository.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI

class MeetsRepository: ObservableObject {
 private let path: String = "meets"
 private let store = Firestore.firestore()
 //Try building user repository here first
 @Published var meets: [Meet] = []
 private var cancellables: Set<AnyCancellable> = []
 init() {
  self.get()
 }
  
 func get() {
   store.collection(path).getDocuments { snapshot, error in
     if error == nil {
       if let snapshot = snapshot {
         DispatchQueue.main.async {
           self.meets = snapshot.documents.map { d in
              Meet(id: d.documentID,
                   title: d["title"] as? String ?? "",
                   location: d["location"] as? String ?? "",
                   startTime: d["startTime"] as? Timestamp ?? Timestamp(),
                   endTime: d["endTime"] as? Timestamp ?? Timestamp(),
                   joined: d["joined"] as? Int ?? 0,
                   capacity: d["capacity"] as? Int ?? 0,
                   icon: d["icon"] as? String ?? "",
                   latitude: Double((d["latitude"]! as! NSNumber)),
                   longitude: Double((d["longitude"]! as! NSNumber)),
                   host: d["host"] as? String ?? "",
                   people: d["people"] as? [String] ?? [""]
             )
           }
         }
       }
     }
   }
 }
 // MARK: CRUD methods
 func add(_ meet: Meet) {
  do {
   let newMeet = meet
   _ = try store.collection(path).addDocument(from: newMeet)
  } catch {
   fatalError("Unable to add Meet: \(error.localizedDescription).")
  }
 }
 func update(_ meet: Meet) {
  guard let meetId = meet.id else { return }
  do {
   try store.collection(path).document(meetId).setData(from: meet)
  } catch {
   fatalError("Unable to update Meet: \(error.localizedDescription).")
  }
 }
 func remove(_ meet: Meet) {
  guard let meetId = meet.id else { return }
  store.collection(path).document(meetId).delete { error in
   if let error = error {
    print("Unable to remove Meet: \(error.localizedDescription)")
   }
  }
 }
 // MARK: Filtering methods
 //func getMeetsBy(_ host: String) -> [Meet] {
   //return self.meets.filter{$0.host.name == host}
 //}
}
