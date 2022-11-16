//
//  Gender.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/9/22.
//

import Foundation

enum Gender: String {
  case male = "Male"
  case female = "Female"
  case other = "Other"
  case none = "Prefer not to say"
  
  static let allGenders = ["Male", "Female", "Other", "Prefer not to say"]
}
