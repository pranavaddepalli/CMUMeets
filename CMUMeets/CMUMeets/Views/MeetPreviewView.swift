//
//  MeetPreviewView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/20/22.
//

import SwiftUI
import MapKit
import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeetPreviewView: View {
  var annotation:  MeetAnnotation
  
  @State private var clicked: Bool = false
  @State private var alertShown = false
  @State private var alert2Shown = false

  var body: some View {
    NavigationStack {
      VStack {
        // CREATE A MEET MODEL USING ANNOTATION.MEET!
        HStack {
          Spacer()
          VStack {
            Text("@" + annotation.meet.location)
            Text("Start: " + self.getStartTime())
          }
          Spacer()
          Text("Joined: " + String(annotation.meet.joined) + "/" + String(annotation.meet.capacity))
          Spacer()
        }
        HStack {
          Spacer()
          NavigationLink(destination: MeetPreviewDetailsView(firebase: annotation.firebase, meet: annotation.meet)) {
            Text("See more")
              .foregroundColor(.black)
              .padding()
              .overlay(
                  RoundedRectangle(cornerRadius: 15)
                      .stroke(Color.blue, lineWidth: 4)
              )
          }
          Spacer()
          
          
          
          // https://developer.apple.com/documentation/swiftui/navigationstack
          // Use this resource once we implement user info, to change the display for meets that you've already joined
            
            if (annotation.meet.host == annotation.firebase.currentUser.id!) {
                // you are the host, so you should delete meets
                
                Button(action:  {
                        annotation.firebase.deleteMeet(meet: annotation.meet)
                        clicked = true
                        alert2Shown = true
                   
                    
                }) {
                    Text("Delete Meet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
                .disabled(clicked)

            
            }
          
            else if (!annotation.firebase.joinedMeets.contains(annotation.meet)){
                Button(action:  {
                    if annotation.meet.joined < annotation.meet.capacity {
                        annotation.firebase.joinMeet(meet: annotation.meet)
                        clicked = true
                    }
                    else {
                        alertShown = true
                    }
                    
                }) {
                    Text("Join Meet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                .disabled(clicked)
                .alert("This Meet is Full!", isPresented: $alertShown, actions: {})
            }
            else {
                Button(action:  {
                    annotation.firebase.leaveMeet(meet: annotation.meet)
                      clicked = true
                    
                }) {
                    Text("Leave Meet")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(15.0)
                }
                .disabled(clicked)
            }
          // Change this to the green button found in the See More navigation link so that joining a meet actually happens
          Spacer()
          
        }
      }
    }
  }
  
  func getStartTime() -> String {
    let startTimeDate = annotation.meet.startTime.dateValue()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.string(from: startTimeDate)
  }
  
}


