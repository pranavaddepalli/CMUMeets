//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MeetDetails().tabItem {
                Image(systemName: "calendar")
            }
            NewUserView().tabItem {
                Image(systemName: "person.badge.plus")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
