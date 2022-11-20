//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var firebase: Firebase = Firebase()
  @State private var showingHostView = false
  var hostViewModel = HostViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        TabView {
          VStack {
            MapView(firebase: firebase).edgesIgnoringSafeArea(.all)
            Button("Host a meet") {
              showingHostView = true;
            }
            .sheet(isPresented: $showingHostView) {
              HostView(hostViewModel: hostViewModel)
            }
          }
          .tabItem {
            Image(systemName: "books.vertical")
            Text("MapView")
          }
          LocationView(firebase: firebase)
            .tabItem {
              Image(systemName: "books.vertical")
              Text("LocationView")
            }
          DummyView(firebase: firebase)
            .tabItem {
              Image(systemName: "books.vertical")
              Text("LocationView")
            }
          MeetDetails().tabItem {
            Image(systemName: "calendar")
          }
          NewUserView().tabItem {
            Image(systemName: "person.badge.plus")
          }
        }
      }
    }
  }
}
