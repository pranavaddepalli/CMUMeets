//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct MainPageView: View {
  @ObservedObject var meetsLibraryViewModel: MeetsLibraryViewModel
  @ObservedObject var firebase: Firebase
  @State private var showingHostView = false
  var hostViewModel = HostViewModel()
  
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
          MeetDetails(meetsLibraryViewModel: meetsLibraryViewModel, firebase: firebase).tabItem {
            Image(systemName: "calendar")
            Text("Meets")
          }
          NewUserView().tabItem {
            Image(systemName: "person.badge.plus")
            Text("Register")
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

