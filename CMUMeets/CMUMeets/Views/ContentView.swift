//
//  ContentView.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewController: ViewController = ViewController()
  
    var body: some View {
        NavigationView {
            VStack {
              TabView {
                MapView(viewController: viewController)
                .tabItem {
                  Image(systemName: "books.vertical")
                  Text("MapView")
                }
                HostView()
                .tabItem {
                  Image(systemName: "books.vertical")
                  Text("HostView")
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
