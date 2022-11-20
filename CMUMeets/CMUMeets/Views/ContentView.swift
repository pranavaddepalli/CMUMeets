//
//  ContentView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var viewController: ViewController
  @ObservedObject var meetsLibraryViewModel: MeetsLibraryViewModel

  
  var body: some View {
      LoginView(viewController: viewController, meetsLibraryViewModel: meetsLibraryViewModel)
  }
}
