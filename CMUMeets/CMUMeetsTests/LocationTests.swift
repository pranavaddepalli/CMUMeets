//
//  MeetAnnotationTests.swift
//  CMUMeets
//
//  Created by Ricky Lee on 12/8/22.
//

@testable import CMUMeets
import Foundation
import CoreLocation
import XCTest


class LocationTests: XCTestCase {
  func testInit() {
    let instance = Location()

    // Assert Not Nil Tests
    XCTAssertNotNil(instance)
    XCTAssertNotNil(instance.locationManager)
    XCTAssertNotNil(instance.latitude)
    XCTAssertNotNil(instance.longitude)

    //Assert True Tests
    XCTAssertTrue(instance.latitude == 40.4432027)
    XCTAssertTrue(instance.longitude == -79.9428499)
    
    //Assert False Tests
    XCTAssertFalse(instance.latitude == -3)
    XCTAssertFalse(instance.longitude == 5)
  }
  
  func testClearLocation() {
    let instance = Location()
    instance.clearLocation()
    
    XCTAssertNotNil(instance)
    XCTAssertNotNil(instance.locationManager)
    XCTAssertNotNil(instance.latitude)
    XCTAssertNotNil(instance.longitude)

    //Assert True Tests
    XCTAssertTrue(instance.latitude == 0)
    XCTAssertTrue(instance.longitude == 0)
    
    //Assert False Tests
    XCTAssertFalse(instance.latitude == -3)
    XCTAssertFalse(instance.longitude == 5)
  }
  
  func testStringByAppendingPathComponent() {
    let instance = "Hello"
    instance.stringByAppendingPathComponent(aPath: "/World")
    XCTAssertNotNil(instance)
  }
  
  func testSaveLocation() {
    let instance = Location()
    instance.saveLocation()
    XCTAssertNotNil(instance)
  }
  
  func testGetCurrentLocation() {
    let instance = Location()
    instance.getCurrentLocation()
    XCTAssertNotNil(instance)
  }
  
  func testDocumentsDirectory() {
    let instance = Location()
    instance.documentsDirectory()
    XCTAssertNotNil(instance)
  }
  
  func testDataFilePath() {
    let instance = Location()
    instance.dataFilePath()
    XCTAssertNotNil(instance)
  }
  
  func testLoadLocation() {
    let instance = Location()
    instance.loadLocation()
    XCTAssertNotNil(instance)
  }
}
