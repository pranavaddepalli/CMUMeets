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
  
//
//                      LocationView()
//                      .tabItem(
//                        Image(systemName: "books.vertical")
//                        Text("HostView")
//                      )
//                      LocationView()
//                      .tabItem(
//                        Image(systemName: "books.vertical")
//                        Text("HostView")
//                      )
                }
//                NavigationLink(destination: MapView(viewController: viewController).navigationBarTitle("MapView!")) {
//                    Text("Host view test1")
//                }
//
//                Spacer()
//
//              NavigationLink(destination: HostView().navigationBarTitle("HostView!")) {
//                  Text("Host view test2")
//              }
//
//              Spacer()
//
//              NavigationLink(destination: LocationView(viewController: viewController).navigationBarTitle("LocationView!")) {
//                  Text("Host view test3")
//              }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
