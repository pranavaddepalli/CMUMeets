//
//  HostView.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI
import FirebaseFirestore


struct HostView: View {
  @ObservedObject var hostViewModel = HostViewModel()
  @State var meetName: String = ""
  @State var meetCapacity: Int = 1 
  
  @State var meetIcon: HostViewModel.MeetIcon = .hangout
  @State var meetLoc: String = ""
  
  var body: some View {
    VStack {
      Text("New Meet")
        .font(.title)
        .fontWeight(.bold)
      
        HStack {
          TextField("Title",
                    text: $meetName)
            .textFieldStyle(.roundedBorder)
          
          Spacer()

          Picker("Location", selection: $meetLoc) {
            ForEach(hostViewModel.getLocationNames(), id: \.self) { loc in Text(loc)}
          }
          
        }
        .padding()
      
      Picker("Icon", selection: $meetIcon) {
        Text("🍽 Food").tag(HostViewModel.MeetIcon.food)
        Text("⛹️ Sport").tag(HostViewModel.MeetIcon.sport)
        Text("🎪 Hangout").tag(HostViewModel.MeetIcon.hangout)
      }
      .pickerStyle(.segmented)
      
      
      
     
      Spacer()
      
    }
    .padding()
  }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        HostView()
    }
}
