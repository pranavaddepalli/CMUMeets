//
//  User.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
struct User: Codable, Identifiable, Comparable {
  @DocumentID var id: String?
  var name: String
  var phone: String
  var major: String
  var gradYear: Int
  var age: Int
  var gender: String
  var pronouns: String
  var ethnicity: String

//  enum CodingKeys: String, CodingKey {
//    case name
//    case phone
//    case major
//    case gradYear
//    case age
//    case gender
//    case pronouns
//    case ethnicity
//  }
//
  static func ==(lhs: User, rhs: User) -> Bool {
    return lhs.name == rhs.name && lhs.phone == rhs.phone
  }
  static func <(lhs: User, rhs: User) -> Bool {
   return lhs.name < rhs.name
  }
}
