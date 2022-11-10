//
//  ContentView.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI

struct ContentView: View {
  @State private var showingHostView = false
  var hostViewModel = HostViewModel()

    var body: some View {
          VStack {
              Image(systemName: "globe")
                  .imageScale(.large)
                  .foregroundColor(.accentColor)
              Text("Hello, world!")
              
              Spacer()
                
            Button("Host a meet") {
              showingHostView = true;
            }
            .sheet(isPresented: $showingHostView) {
              HostView(hostViewModel: hostViewModel)
            }
            
              
            Spacer()
              
          }
      }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
