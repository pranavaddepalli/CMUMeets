//
//  LocationModel.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
struct LocationModel: Codable, Comparable, Hashable {
  var code: String
  var latitude: Double
  var longitude: Double
  var name: String

//  enum CodingKeys: String, CodingKey {
//    case code
//    case latitude
//    case longitude
//    case name
//
  
  static func ==(lhs: LocationModel, rhs: LocationModel) -> Bool {
    return lhs.code == rhs.code
  }
  static func <(lhs: LocationModel, rhs: LocationModel) -> Bool {
   return lhs.name < rhs.name
  }
}
