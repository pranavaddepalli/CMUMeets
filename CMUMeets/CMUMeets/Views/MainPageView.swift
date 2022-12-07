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
    NavigationView {
      VStack {
        TabView {
          VStack {
            MapView(firebase: firebase)
            Button("Host a meet") {
              showingHostView = true;
            }
            .sheet(isPresented: $showingHostView) {
              HostView(firebase: firebase)
            }
          }
          .tabItem {
            Image(systemName: "books.vertical")
            Text("MapView")
          }
         
    
          MeetDetails(firebase: firebase).tabItem {
            Image(systemName: "calendar")
            Text("Meets")
          }
          CurrentUserView(firebase: firebase).tabItem {
            Image(systemName: "person.fill")
            Text("User Profile")
          }
        }
      }
    }
  }
}

