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
        
        
        VStack {
            Text("\(meet.icon) \(meet.title)")
                .font(.title)
                .fontWeight(.bold)
            
            
            HStack (alignment: .center){
                Text("@ " + meet.location)

            }
            VStack {
                Text("Hosted by: " + (firebase.users[meet.host]?.name ?? "unknown"))
                Text("Host's Phone: " + (firebase.users[meet.host]?.phone ?? "unknown"))
                
                
            }
            HStack{
                Text("Start: " + meet.getStartString().split(separator: " ")[1])
                Text("End: " + meet.getEndString().split(separator: " ")[1])
                
                    .padding()
            }
            Text("Joined: " + String(meet.joined) + "/" + String(meet.capacity))
            
            HStack {
                ForEach(meet.people, id: \.self) {p in
                    VStack{
                        Text("🧍" + (firebase.users[p]?.name ?? "unknown"))}
                }
            }.padding()
            Spacer()

                        
          
            if (meet.host == firebase.currentUser.id!) {
                // you are the host, so you should delete meets
                
                Button(action:  {
                    firebase.deleteMeet(meet: meet)
                    
                }) {
                    Text("Delete Meet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
                
            }
            
            else if (!firebase.joinedMeets.contains(meet)){
                Button(action:  {
                    if meet.joined < meet.capacity {
                        firebase.joinMeet(meet: meet)
                    }
                    else {
                        alertShown = true
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
            }
            else {
                Button(action:  {
                    firebase.leaveMeet(meet: meet)
                    
                }) {
                    Text("Leave Meet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
            }
        }
        Spacer()
    }
}
