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
             return Meet(id: d.documentID,
                   title: d["title"] as? String ?? "",
                   location: d["location"] as? String ?? "",
                         timeStart: (d["timeStart"] as? Timestamp ?? Timestamp()).dateValue().timeIntervalSinceNow,
                   timeEnd: d["timeEnd"] as? Date ?? Date(),
                   host: d["host"] as? User ?? User(id: "", name: "", phone: "", major: "", gradYear: 0, age: 0, gender: "", pronouns: "", ethnicity: ""),
                   people: d["people"] as? [User] ?? [],
                   capacity: d["capacity"] as? Int ?? 0
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
 func getMeetsBy(_ host: String) -> [Meet] {
   return self.meets.filter{$0.host.name == host}
 }
}