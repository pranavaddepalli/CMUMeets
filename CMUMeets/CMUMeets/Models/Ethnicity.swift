//
//  Ethnicity.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/9/22.
//

import Foundation

enum Ethnicity: String {
  case native = "American Indian or Alaskan Native"
  case asian = "Asian"
  case african = "Black or African American"
  case hispanic = "Hispanic or Latino"
  case island = "Native Hawaiian or Other Pacific Islander"
  case white = "White"
  case other = "Other"
  case none = "Prefer not to say"
  
  static let allEthnicities = ["American Indian or Alaskan Native", "Asian", "Black or African American", "Hispanic or Latino", "Native Hawaiian or Other Pacific Islander", "White", "Other", "Prefer not to say"]
}
