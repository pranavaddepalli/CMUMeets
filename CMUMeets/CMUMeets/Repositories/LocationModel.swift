//
//  LocationModel.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
struct LocationModel: Codable, Identifiable, Comparable {
  @DocumentID var id: String?
  var code: String
  var latitude: Float
  var longitude: Float
  var name: String


//  enum CodingKeys: String, CodingKey {
//    case code
//    case latitude
//    case longitude
//    case name
//
  
  static func ==(lhs: LocationModel, rhs: LocationModel) -> Bool {
    return lhs.name == rhs.name
  }
  static func <(lhs: LocationModel, rhs: LocationModel) -> Bool {
   return lhs.name < rhs.name
  }
}
