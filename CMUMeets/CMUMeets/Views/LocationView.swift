//
//  LocationView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import SwiftUI
import FirebaseFirestore


func test_loc(locations: [Dictionary<String,Any>]) -> String {
    var db = Firestore.firestore()
    var locs = locations
    db.collection("locations").getDocuments() { (querySnapshot, err) in
        if let err = err {
            print("Error getting documents: \(err)")
        } else {
            for document in querySnapshot!.documents {
                print("\(document.documentID) => \(document.data())")
              print(type(of: document.data()))
              locs.append(document.data())
              // refresh map?
            }
        }
    }
    return "success"
}



struct LocationView: View {
    var locations: [Dictionary<String,Any>] = []

    var body: some View {
        Text("location meet page")
      Text(test_loc(locations: locations))
    }
}


