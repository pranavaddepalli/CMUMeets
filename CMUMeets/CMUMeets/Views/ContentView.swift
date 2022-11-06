//
//  ContentView.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text("Hello, world!")
                
                Spacer()
                
                NavigationLink(destination: HostView().navigationBarTitle("Host a Meet!")) {
                    Text("Host view test1")
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
