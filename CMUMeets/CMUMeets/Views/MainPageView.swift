//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct MainPageView: View {
  @ObservedObject var viewController: ViewController = ViewController()
  @State private var showingHostView = false
  var hostViewModel = HostViewModel()
  
  var body: some View {
    NavigationView {
      VStack {
        TabView {
          VStack {
            MapView(viewController: viewController)
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
          LocationView(viewController: viewController)
            .tabItem {
              Image(systemName: "books.vertical")
              Text("LocationView")
            }
          DummyView(viewController: viewController)
            .tabItem {
              Image(systemName: "books.vertical")
              Text("LocationView")
            }
          MeetDetails().tabItem {
            Image(systemName: "calendar")
            Text("Meets")
          }
          NewUserView().tabItem {
            Image(systemName: "person.badge.plus")
            Text("Register")
          }
          CurrentUserView().tabItem {
            Image(systemName: "person.fill")
            Text("User Profile")
          }
        }
      }
    }
  }
}

