//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct ContentView: View {
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
          }
          NewUserView().tabItem {
            Image(systemName: "person.badge.plus")
          }
//          CurrentUser().tabItem {
//            Image(systemName: "person.crop.circle")
//          }
        }
      }
    }
  }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
