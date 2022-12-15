//
//  Location.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/8/22.
//

import Foundation
import CoreLocation

extension String {
  // recreating a function that String class no longer supports in Swift 2.3
  // but still exists in the NSString class. (This trick is useful in other
  // contexts as well when moving between NS classes and Swift counterparts.)
  
  /**
   Returns a new string made by appending to the receiver a given string.  In this case, a new string made by appending 'aPath' to the receiver, preceded if necessary by a path separator.
   
   - parameter aPath: The path component to append to the receiver. (String)
   
   - returns: A new string made by appending 'aPath' to the receiver, preceded if necessary by a path separator. (String)
   
  */
  func stringByAppendingPathComponent(aPath: String) -> String {
    let nsSt = self as NSString
    return nsSt.appendingPathComponent(aPath)
  }
}

class Location: NSObject {
  
  var latitude: CLLocationDegrees
  var longitude: CLLocationDegrees
  var locationManager = CLLocationManager()
  
  override init() {
    // fence
    self.latitude = 40.4432027   
    self.longitude = -79.9428499
    super.init()
  }
    
  func saveLocation() {
    let data = NSMutableData()
    let archiver = NSKeyedArchiver(forWritingWith: data)
    archiver.encode(self.latitude, forKey: "latitude")
    archiver.encode(self.longitude, forKey: "longitude")
    archiver.finishEncoding()
    data.write(toFile: dataFilePath(), atomically: true)
  }
  
  func getCurrentLocation() {
    self.clearLocation()
    locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.distanceFilter = kCLDistanceFilterNone
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      locationManager.startUpdatingLocation()
    }
    
    if let currLocation = locationManager.location {
      self.latitude = currLocation.coordinate.latitude
      self.longitude = currLocation.coordinate.longitude
    }
      self.saveLocation()
  }

  func documentsDirectory() -> String {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
  }

  func dataFilePath() -> String {
    return documentsDirectory().stringByAppendingPathComponent(aPath: "Coordinates.plist")
  }

  func loadLocation() {
    let path = dataFilePath()
    if FileManager.default.fileExists(atPath: path) {
      if let data = NSData(contentsOfFile: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
        self.latitude = unarchiver.decodeDouble(forKey: "latitude")
        self.longitude = unarchiver.decodeDouble(forKey: "longitude")
        unarchiver.finishDecoding()
      } else {
        print("\nFILE NOT FOUND AT: \(path)")
      }
    }
  }
  
  func clearLocation () {
    self.latitude = 0.00
    self.longitude = 0.00
  }
}
