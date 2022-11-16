//
//  MeetDetailsView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore

struct MeetDetailsView: View {
    var meet: Meet
    @State private var clicked: Bool = false
    @State private var alertShown = false
    
    var body: some View {
        Text(meet.title)
        Text("Location: " + meet.location)
        Text("Start: " + meet.getStartString())
        Text("End: " + meet.getEndString())
        Text("Joined: " + String(meet.joined))
        Text("Capacity: " + String(meet.capacity))
        Button("JOIN MEET") {
            if meet.joined < meet.capacity {
                joinMeet()
                clicked = true
            }
            else {
                alertShown = true
            }
        }
        .disabled(clicked)
        .alert("This Meet is Full!", isPresented: $alertShown, actions: {})
    }
    
    func joinMeet() {
        let db = Firestore.firestore()
        let path = db.collection("meets").document(self.meet.id!)
        path.updateData([
            "capacity": meet.capacity + 1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
            else {
                print("Document updated successfully")
            }
        }
    }
}
