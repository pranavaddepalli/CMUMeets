//
//  Meet.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
struct Meet: Codable, Identifiable , Comparable {
  @DocumentID var id: String?
  var title: String
  var location: String
  var timeStart: TimeInterval
  var timeEnd: Date
  var host: User
  var people: [User]
  var capacity: Int
//  enum CodingKeys: String, CodingKey {
//    case id
//    case location
//    case timeStart
//    case timeEnd
//    case host
//    case people
//    case capacity
//  }
//
  static func ==(lhs: Meet, rhs: Meet) -> Bool {
    return lhs.title == rhs.title && lhs.host == rhs.host
  }
  static func <(lhs: Meet, rhs: Meet) -> Bool {
   return lhs.title < rhs.title
  }
}
