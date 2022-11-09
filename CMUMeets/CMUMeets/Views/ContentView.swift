//
//  ContentView.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI

struct ContentView: View {
    let viewController: ViewController = ViewController()

    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                
                Spacer()
                
                NavigationLink(destination: MapView(viewController: viewController).navigationBarTitle("MapView!")) {
                    Text("Host view test1")
                }
                
                Spacer()
              
              NavigationLink(destination: HostView().navigationBarTitle("HostView!")) {
                  Text("Host view test2")
              }
              
              Spacer()
              
              NavigationLink(destination: LocationView().navigationBarTitle("LocationView!")) {
                  Text("Host view test3")
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
