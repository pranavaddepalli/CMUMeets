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
            if meet.joined < meet.capacity {
                firebase.joinMeet(meet: meet)
            }
            else {
                alertShown = true
                if meet.joined == meet.capacity {
                    alertMessage = "This Meet is Full!"
                }
                if firebase.joinedMeets.contains(meet) {
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
    
}
