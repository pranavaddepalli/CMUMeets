//
//  HostView.swift
//  CMUMeets›‹
//
//  Created by Pranav Addepalli on 11/5/22.
//

import SwiftUI
import FirebaseFirestore
import MapKit



struct HostView: View {
  @ObservedObject var hostViewModel = HostViewModel()
  @State var selection: Int? = nil

  @State var meetName: String = ""
  @State var meetCapacity: Int = 1
  @State var meetIcon = HostViewModel.MeetIcon.hangout
  @State var meetLoc: LocationSetup.Location = LocationSetup.Location (
    code: "FENCE",
    title: "The Fence",
    latitude : 40.4432027,
    longitude : -79.9428499
  )
  // add pin to map
  @State var meetStartTime: Date = Date.now
  @State var meetEndTime: Date = Date.now.advanced(by: 1800) // 30 min later
  
  
  @State private var failedMsg = ""
//  @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.4447434, longitude: -79.9420948), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))

  
  var body: some View {
    VStack {
      Text("New Meet")
        .font(.title)
        .fontWeight(.bold)
      
      TextField("Title",
                text: $meetName)
        .textFieldStyle(.roundedBorder)
        .padding()
      
      Picker("Icon", selection: $meetIcon) {
        Text("🍽 Food").tag(HostViewModel.MeetIcon.food)
        Text("⛹️ Sport").tag(HostViewModel.MeetIcon.sport)
        Text("🎪 Hangout").tag(HostViewModel.MeetIcon.hangout)
      }
      .pickerStyle(.segmented)
      .padding()
      
      HStack{
        Spacer()
        
        Text("Capacity")
          .padding()
        TextField("Capacity", value: $meetCapacity, formatter: NumberFormatter())
          .keyboardType(.decimalPad)
          .textFieldStyle(.roundedBorder)
          .fixedSize()
        
        Spacer()
        
        Picker("Location", selection: $meetLoc) {
          ForEach(hostViewModel.getLocations(), id: \.self) { loc in Text(loc.title).tag(loc)}
        }
        .padding()
        
        Spacer()
      }
      
      HStack{
        DatePicker("From:", selection: $meetStartTime, displayedComponents: .hourAndMinute)
          .padding(.leading)
        
        DatePicker("To:", selection: $meetEndTime, displayedComponents: .hourAndMinute)
          .padding()
      }
        
      Spacer()
      
      Button(action: {
        self.failedMsg = hostViewModel.hostMeet(meetName: meetName,
                               icon: meetIcon,
                               capacity: meetCapacity,
                               loc: meetLoc,
                               start: meetStartTime,
                               end: meetEndTime)
        if(self.failedMsg.isEmpty){
          // there were no issues, go back
          
        }
      }) {
        Text("Host!")
          .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.red)
          .padding()
          .overlay(
            RoundedRectangle(cornerRadius: 10)
              .stroke(Color.red, lineWidth: 3)
          )
      }.alert(self.failedMsg, isPresented:
                Binding<Bool>(get: { !self.failedMsg.isEmpty}, set: { _ in })
      ) {
        Button("OK", role: .cancel) {
          self.failedMsg = ""
        }
      }
      }
       .padding()
      
      Text("Meets can only be scheduled for the current day, \(Date.now.formatted(Date.FormatStyle().month()))" + " \(Date.now.formatted(Date.FormatStyle().day())).")
      
      Spacer()
      
//      Map(coordinateRegion: $region,
//          interactionModes: [.zoom],
//          showsUserLocation: true, userTrackingMode: .constant(.follow))
//        .padding()
//
//      Spacer()
      
    
    .padding()
  }
  
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
        HostView()
    }
}
