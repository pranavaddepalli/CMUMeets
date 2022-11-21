//
//  MeetPreviewView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/20/22.
//

import SwiftUI
import MapKit

struct MeetPreviewView: View {
  var annotation:  MKAnnotation
  var firebase = Firebase()
  var body: some View {
    NavigationStack {
      VStack {
        Text(annotation.subtitle!!)
        HStack {
          NavigationLink(destination: DummyView(firebase: firebase)) {
            Text("See more")
              .foregroundColor(.black)
              .padding()
              .overlay(
                  RoundedRectangle(cornerRadius: 15)
                      .stroke(Color.blue, lineWidth: 4)
              )
          }
          
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
          
        }
      }
    }
  }
}



