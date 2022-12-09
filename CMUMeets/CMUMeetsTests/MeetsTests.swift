//
//  MeetsTests.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 12/8/22.


import XCTest
import Firebase

class MeetsTests: XCTestCase {
  func testInit() {
      let instance = Meet(title: "World Cup Watching", location: "The UC", startTime: Timestamp(seconds: 1670544607, nanoseconds: 1681980000), endTime: Timestamp(seconds: 1670546407, nanoseconds: 668198000), joined: 2, capacity: 14, icon: "Mug", latitude: 40.44320297241211, longitude: -79.9428482055664)


    XCTAssertNotNil(instance)
    XCTAssertNotNil(instance.title)
    XCTAssertNotNil(instance.location)
    XCTAssertNotNil(instance.startTime)
    XCTAssertNotNil(instance.endTime)
    XCTAssertNotNil(instance.joined)
    XCTAssertNotNil(instance.capacity)
    XCTAssertNotNil(instance.icon)
    XCTAssertNotNil(instance.latitude)
    XCTAssertNotNil(instance.longitude)

    //Assert True Tests
    XCTAssertTrue(instance.title == "World Cup Watching")
    XCTAssertTrue(instance.location == "The UC")
    XCTAssertTrue(instance.startTime == Timestamp(seconds: 1670544607, nanoseconds: 1681980000))
    XCTAssertTrue(instance.endTime == Timestamp(seconds: 1670546407, nanoseconds: 668198000))
    XCTAssertTrue(instance.joined == 2)
    XCTAssertTrue(instance.capacity == 14)
    XCTAssertTrue(instance.icon == "Mug")
    XCTAssertTrue(instance.latitude == 40.44320297241211)
    XCTAssertTrue(instance.longitude == -79.9428482055664)


    //Assert False Tests
    XCTAssertFalse(instance.title == "Watching TV")
    XCTAssertFalse(instance.location == "Tepper")
    XCTAssertFalse(instance.startTime == Timestamp(seconds: 1111111111, nanoseconds: 111111111))
    XCTAssertFalse(instance.endTime == Timestamp(seconds: 1211111111, nanoseconds: 121111111))
    XCTAssertFalse(instance.joined == 5)
    XCTAssertFalse(instance.capacity == 23)
    XCTAssertFalse(instance.icon == "Map")
    XCTAssertFalse(instance.latitude == 10.00000002201)
    XCTAssertFalse(instance.longitude == -5.3232345643255)

    //Tests for Functions
    let dictInstance: [String: AnyHashable] = instance.toAnyObject()
    XCTAssertTrue(dictInstance["title"] as! String == instance.title)
    XCTAssertTrue(dictInstance["location"] as! String == instance.location)
    XCTAssertTrue(dictInstance["startTime"] as! Timestamp == instance.startTime)
    XCTAssertTrue(dictInstance["endTime"] as! Timestamp == instance.endTime)
    XCTAssertTrue(dictInstance["joined"] as! Int == instance.joined)
    XCTAssertTrue(dictInstance["capacity"] as! Int == instance.capacity)
    XCTAssertTrue(dictInstance["icon"] as! String == instance.icon)
    XCTAssertTrue(dictInstance["latitude"] as! Double == instance.latitude)
    XCTAssertTrue(dictInstance["longitude"] as! Double == instance.longitude)

  }
}

