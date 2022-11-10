//
//  Location.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 11/7/22.
//

import Foundation
import FirebaseFirestore

class LocationSetup {
  struct Location : Hashable {
    let code : String
    let title : String
    let latitude : Double
    let longitude : Double
  }
  
  let locsraw = [
    ["code" : "AH", "name" : "Alumni House", "latitude" : 40.4447434, "longitude" : -79.9420948],
    ["code" : "AN", "name" : "Ansys Hall", "latitude" : 40.4419002, "longitude" : -79.94671],
    ["code" : "BH", "name" : "Baker Hall", "latitude" : 40.4413345, "longitude" : -79.9442745],
    ["code" : "CUC", "name" : "The UC", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "CFA", "name" : "CFA", "latitude" : 40.4418627, "longitude" : -79.9428737],
    ["code" : "DH", "name" : "Doherty Hall", "latitude" : 40.4424563, "longitude" : -79.9445862],
    ["code" : "GHC", "name" : "Gates-Hillman Center", "latitude" : 40.4436655, "longitude" : -79.9444765],
    ["code" : "GESLING", "name" : "Gesling Stadium", "latitude" : 40.4431398, "longitude" : -79.9402817],
    ["code" : "HOA", "name" : "Hall of the Arts", "latitude" : 40.4406681, "longitude" : -79.9422936],
    ["code" : "HBH", "name" : "Hamburg Hall", "latitude" : 40.4443216, "longitude" : -79.9456406],
    ["code" : "HH", "name" : "Hamerschlag Hall", "latitude" : 40.4421988, "longitude" : -79.9466964],
    ["code" : "HL", "name" : "Hunt Library", "latitude" : 40.4411171, "longitude" : -79.9437361],
    ["code" : "MM", "name" : "Margaret Morrison", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "MI", "name" : "Mellon Institute", "latitude" : 40.4461321, "longitude" : -79.9510204],
    ["code" : "NSH", "name" : "Newell-Simon Hall", "latitude" : 40.443428, "longitude" : -79.9456134],
    ["code" : "PH", "name" : "Porter Hall", "latitude" : 40.4415995, "longitude" : -79.9462885],
    ["code" : "POS", "name" : "Posner Hall", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "PCA", "name" : "Purnell Center", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "TCS", "name" : "TCS", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "TEP", "name" : "Tepper", "latitude" : 40.4450795, "longitude" : -79.9453962],
    ["code" : "WEH", "name" : "Wean Hall", "latitude" : 40.4427217, "longitude" : -79.9457395],
    ["code" : "WWG", "name" : "West Wing", "latitude" : 40.4426896, "longitude" : -79.9409075],
    ["code" : "SC3", "name" : "3SC Building", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "SC4", "name" : "4SC Building", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "CUT", "name" : "The Cut", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "CFALAWN", "name" : "CFA Lawn", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "MALL", "name" : "The Mall", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "TENNIS", "name" : "Tennis Courts", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "GQUAD", "name" : "Greek Quad", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "SOCCER", "name" : "Soccer Field", "latitude" : 40.4427179, "longitude" : -79.9386727],
    ["code" : "SCHENLEY", "name" : "Schenley Park", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "FENCE", "name" : "The Fence", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "CLYDE", "name" : "Fifth and Clyde", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "DON", "name" : "Donner", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "FFX", "name" : "Fairfax Apts", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "HAM", "name" : "Hamerschlag Housing", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "HEN", "name" : "Henderson", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "GROW", "name" : "Greek Row", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "MCG", "name" : "McGill", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "MOE", "name" : "E-Tower", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "MOR", "name" : "Morewood Gardens", "latitude" : 40.4450621, "longitude" : -79.9432088],
    ["code" : "MUD", "name" : "Mudge", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "NVL", "name" : "Neville Apts", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "RESFIFTH", "name" : "Res on 5th", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "RESNIK", "name" : "Resnik", "latitude" : 40.4425441, "longitude" : -79.9401256],
    ["code" : "SCO", "name" : "Scobell", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "STE", "name" : "Stever", "latitude" : 40.4432027, "longitude" : -79.9428499],
    ["code" : "GAR", "name" : "East Campus Parking Garage", "latitude" : 40.4438318, "longitude" : -79.9400729]
  ]
  
  var locs = [Location]()
  
  init() {
    // from https://docs.google.com/spreadsheets/d/1SoSMEhr0lqqt5qkxmHVyEAmePOGACVdY_NissKrjnok/edit?usp=sharing
    
    let db = Firestore.firestore()
    
//    for loc in locsraw {
//      db.collection("locations").document(loc["code"] as! String).setData(loc)
//      self.locs.append(Location(
//        code: loc["code"] as! String,
//        title: loc["name"] as! String,
//        latitude: loc["latitude"] as! Double,
//        longitude: loc["longitude"] as! Double
//      ))
//    }
    print("Successfully synced locations data to Firestore")
  }
}
