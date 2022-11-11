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
    
    var body: some View {
        Text(meet.title)
        Text("Location: " + meet.location)
        Text("Start: " + meet.getStartString())
        Text("End: " + meet.getEndString())
        //Text("Host: " + meet.host.name)
        Text("Capacity: " + String(meet.capacity))
        //Text(meet.people)
        Button("JOIN MEET") {
            if meet.people.count < meet.capacity {
                joinMeet()
                clicked = true
            }
            else {
                Text("This Meet is full!")
            }
        }
        .disabled(clicked)
        
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
