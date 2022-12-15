//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct MainPageView: View {
  @ObservedObject var firebase: Firebase
  
  @State private var showingHostView = false
  
  var body: some View {
      VStack {
        Spacer()
        TabView {
          ZStack {
              MapView(firebase: firebase)
            
              VStack {
                Spacer()
                  
                Button(action: {
                      showingHostView = true;
                  }) {
                      ZStack {
                          // Use a Circle shape to create a circular button
                          Circle()
                              .frame(width: 50, height: 50)
                              .foregroundColor(Color(red: 0x8a/255, green: 0x2b/255, blue: 0x2b/255))
                          
                          // Add a plus icon to the button using an image
                          Image(systemName: "plus")
                              .font(.title)
                              .foregroundColor(.white)
                      }
                  }
                  .sheet(isPresented: $showingHostView) {
                      HostView(firebase: firebase)
                  }
              }
              .padding()
            
          }
          .tabItem {
            Image(systemName: "mappin.circle.fill")
            Text("Home")
          }
         
    
          MeetList(firebase: firebase).tabItem {
            Image(systemName: "calendar")
            Text("Meets")
          }
          CurrentUserView(firebase: firebase).tabItem {
            Image(systemName: "person.fill")
            Text("Profile")
          }
        }
      }
      .background(Color(red: 0xd1/255, green: 0xcc/255, blue: 0xbd/255))
  }
}

