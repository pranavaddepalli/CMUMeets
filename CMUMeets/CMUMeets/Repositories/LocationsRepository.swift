//
//  LocationsRepository.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
class LocationsRepository: ObservableObject {
 private let path: String = "locations"
 private let store = Firestore.firestore()
 //Try building user repository here first
 @Published var locations: [LocationModel] = []
 private var cancellables: Set<AnyCancellable> = []
 init() {
  self.get()
 }
  
 func get() {
   store.collection(path).getDocuments { snapshot, error in
     if error == nil {
       if let snapshot = snapshot {
         DispatchQueue.main.async {
           self.locations = snapshot.documents.map { d in
             return LocationModel(id: d.documentID,
                                  code: d["code"] as? String ?? "",
                                  latitude: d["latitude"] as? Float ?? 0.0,
                                  longitude: d["longitude"] as? Float ?? 0.0,
                                  name: d["String"] as? String ?? ""

             )
           }
         }
       }
     }
   }
 }
 // MARK: CRUD methods
 func add(_ location: LocationModel) {
  do {
   let newLocation = location
   _ = try store.collection(path).addDocument(from: newLocation)
  } catch {
   fatalError("Unable to add Location: \(error.localizedDescription).")
  }
 }
 func update(_ location: LocationModel) {
  guard let locationId = location.id else { return }
  do {
   try store.collection(path).document(locationId).setData(from: location)
  } catch {
   fatalError("Unable to update Location: \(error.localizedDescription).")
  }
 }
 func remove(_ location: LocationModel) {
  guard let locationId = location.id else { return }
  store.collection(path).document(locationId).delete { error in
   if let error = error {
    print("Unable to remove Location: \(error.localizedDescription)")
   }
  }
 }
 // MARK: Filtering methods
 func getLocationsBy(_ name: String) -> [LocationModel] {
   return self.locations.filter{$0.name == name}
 }
}
