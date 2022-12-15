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
  @ObservedObject var firebase: Firebase
  
  @Environment(\.presentationMode) var presentationMode

  @State var meetName: String = ""
  @State var meetCapacity: Int = 2
  @State var meetIcon = "🍽"
  @State var meetLoc: LocationModel = LocationModel (
    code: "FENCE",
    latitude : 40.4432027,
    longitude : -79.9428499,
    name: "The Fence"
  )
  @State var meetStartTime: Date = Date.now
  @State var meetEndTime: Date = Date.now.advanced(by: 1800) // 30 min later
    
  @State private var failedMsg = ""
  
  
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
        Text("🍽 Food").tag("🍽")
        Text("⛹️ Sport").tag("⛹️")
        Text("🎪 Hangout").tag("🎪")
      }
      .pickerStyle(.segmented)
      .padding()
      
        HStack (alignment: .center){
        Text("Capacity:")
          .padding()
        TextField("Capacity", value: $meetCapacity, formatter: NumberFormatter())
          .keyboardType(.numberPad)
          .textFieldStyle(.roundedBorder)
          .fixedSize()
        Spacer()
        }
        
        Spacer()
        
        HStack(alignment: .center) {
            Text("Location:")
              .padding()
            Picker("Location", selection: $meetLoc) {
                ForEach(Array(firebase.locations.values).sorted(), id: \.self) { loc in
                Text(loc.name).tag(loc)}
            }
            Spacer()
        }
     
        
        Spacer()
      
      
      HStack{
        DatePicker("From:", selection: $meetStartTime, displayedComponents: .hourAndMinute)
          .padding(.leading)
        
        DatePicker("To:", selection: $meetEndTime, displayedComponents: .hourAndMinute)
          .padding()
      }
        
      Spacer()
      
      Button(action: {
        
        self.failedMsg = firebase.hostMeet(meetName: meetName,
                               icon: meetIcon,
                               capacity: meetCapacity,
                               loc: meetLoc,
                               start: meetStartTime,
                               end: meetEndTime)
      }) {
        Text("Host!")
              .font(.title)
          .fontWeight(.bold)
          .foregroundColor(.white)
          .padding()
      }.background(Color(red: 0x8a/255, green: 0x2b/255, blue: 0x2b/255))
        
        .cornerRadius(10)
        .alert(isPresented:
                 Binding<Bool>(get: { !self.failedMsg.isEmpty}, set: { _ in })
      ) {
        if (self.failedMsg == "Successfully hosted your Meet!"){
          return Alert(title: Text(self.failedMsg),
                       dismissButton: .default(Text("OK")) {
            presentationMode.wrappedValue.dismiss()
          }
                       )
          }
        else {
          let err = self.failedMsg + "."
          return  Alert(title: Text("Oh no!"),
                        message: Text(err),
                        primaryButton: .destructive(Text("Don't host")) {
            presentationMode.wrappedValue.dismiss()
          }, secondaryButton:.default(Text("I'll fix it"))
          )
        }
      }
      }
       .padding()
      
      Text("Meets can only be scheduled for the current day, \(Date.now.formatted(Date.FormatStyle().month()))" + " \(Date.now.formatted(Date.FormatStyle().day())).").padding()
      
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


