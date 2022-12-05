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
    @ObservedObject var firebase: Firebase
    
    var meet: Meet
    @State private var alertShown = false
    @State private var alertMessage = ""
    
    var body: some View {
        Text(meet.title).fontWeight(.bold).font(.title)
        Text("@ " + meet.location)
        Text("Start: " + meet.getStartString())
        Text("End: " + meet.getEndString())
        Text("Joined: " + String(meet.joined) + "/" + String(meet.capacity))
        Button(action:  {
            if meet.joined < meet.capacity && !firebase.ongoingMeets.contains(meet) {
                joinMeet()
            }
            else {
                alertShown = true
                if meet.joined == meet.capacity {
                    alertMessage = "This Meet is Full!"
                }
                if firebase.ongoingMeets.contains(meet) {
                    alertMessage = "You've already joined this Meet!"
                }
            }
            
        }) {
            Text("Join Meet")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
        }
        .alert(alertMessage, isPresented: $alertShown, actions: {})
    }
    
    func joinMeet() {
        let db = Firestore.firestore()
        let path = db.collection("meets").document(self.meet.id!)
        path.updateData([
            "joined": meet.joined + 1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
            else {
                print("Document updated successfully")
            }
        }
        self.firebase.ongoingMeets.append(meet)
    }
}
