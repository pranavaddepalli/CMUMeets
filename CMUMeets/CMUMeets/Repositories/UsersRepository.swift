//
//  UsersRepository.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
class UsersRepository: ObservableObject {
 private let path: String = "users"
 private let store = Firestore.firestore()
 //Try building user repository here first
 @Published var users: [User] = []
 private var cancellables: Set<AnyCancellable> = []
 init() {
  self.get()
 }
  
 func get() {
   store.collection(path).getDocuments { snapshot, error in
     if error == nil {
       if let snapshot = snapshot {
         DispatchQueue.main.async {
           self.users = snapshot.documents.map { d in
             return User(id: d.documentID,

                         name: d["name"] as? String ?? "",
                         phone: d["phone"] as? String ?? "",
                         major: d["major"] as? String ?? "",
                         gradYear: d["gradYear"] as? String ?? "",
                         age: d["age"] as? String ?? "",
                         gender: d["gender"] as? String ?? "",
                         pronouns: d["pronouns"] as? String ?? "",
                         ethnicity: d["ethnicity"] as? String ?? "",
                         username: d["username"] as? String ?? ""

             )
           }
         }
       }
     }
   }
 }
 // MARK: CRUD methods
 func add(_ user: User) {
  do {
   let newUser = user
   _ = try store.collection(path).addDocument(from: newUser)
  } catch {
   fatalError("Unable to add User: \(error.localizedDescription).")
  }
 }
 func update(_ user: User) {
  guard let userId = user.id else { return }
  do {
   try store.collection(path).document(userId).setData(from: user)
  } catch {
   fatalError("Unable to update User: \(error.localizedDescription).")
  }
 }
 func remove(_ user: User) {
  guard let userId = user.id else { return }
  store.collection(path).document(userId).delete { error in
   if let error = error {
    print("Unable to remove User: \(error.localizedDescription)")
   }
  }
 }
 // MARK: Filtering methods
 func getUsersBy(_ name: String) -> [User] {
   return self.users.filter{$0.name == name}
 }
}
