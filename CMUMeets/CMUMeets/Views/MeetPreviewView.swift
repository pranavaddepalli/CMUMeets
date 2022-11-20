//
//  MeetPreviewView.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/20/22.
//

import SwiftUI
import MapKit

struct MeetPreviewView: View {
  var annotation:  MKAnnotation
  var body: some View {
    VStack {
      Spacer()
      Text(annotation.subtitle!!)
      Spacer()
      HStack {
        Spacer()
        Button("See more") {}
        Spacer()
        Button("Join") {}
        Spacer()
      }
      Spacer()
    }
  }
}



