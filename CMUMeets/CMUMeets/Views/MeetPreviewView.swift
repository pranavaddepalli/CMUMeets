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
  var firebase = Firebase()
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
          NavigationLink(destination: MeetPreviewDetailsView(firebase: firebase, meet: annotation.meet)) {
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
          NavigationLink(destination: Text("Confirmation that you joined this meet.")) {
            Text("Join")
              .foregroundColor(.black)
              .padding()
              .overlay(
                  RoundedRectangle(cornerRadius: 15)
                      .stroke(Color.blue, lineWidth: 4)
              )
          }
          Spacer()
          
        }
      }
    }
  }
  
  // Make this into 12HR time not 24HR time
  func getStartTime() -> String {
    let startTimeDate = annotation.meet.startTime.dateValue()
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    return dateFormatter.string(from: startTimeDate)
  }
}



