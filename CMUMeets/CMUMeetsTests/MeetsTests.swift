//
//  MeetsTests.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 12/14/22.


import XCTest
import Firebase

@testable import CMUMeets

class MeetsTests: XCTestCase {
  func testInit() {
    let instance : Meet = Meet(
      title: "World Cup Watching",
      location: "The UC",
      startTime: Timestamp(),
      endTime: Timestamp(),
      joined: 2,
      capacity: 14,
      icon: "Mug",
      latitude: 40.44320297241211,
      longitude: -79.9428482055664,
      host: "best host",
      people: ["best host", "best attendee"]
    )
   

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
    XCTAssertTrue(instance.joined == 2)
    XCTAssertTrue(instance.capacity == 14)
    XCTAssertTrue(instance.icon == "Mug")
    XCTAssertTrue(instance.latitude == 40.44320297241211)
    XCTAssertTrue(instance.longitude == -79.9428482055664)


    //Assert False Tests
    XCTAssertFalse(instance.title == "Watching TV")
    XCTAssertFalse(instance.location == "Tepper")
    XCTAssertFalse(instance.joined == 5)
    XCTAssertFalse(instance.capacity == 23)
    XCTAssertFalse(instance.icon == "Map")
    XCTAssertFalse(instance.latitude == 10.00000002201)
    XCTAssertFalse(instance.longitude == -5.3232345643255)
    
    
    let instance2 = Meet(
      title: "World Cup Watching",
      location: "The UC",
      startTime: Timestamp(),
      endTime: Timestamp(),
      joined: 2,
      capacity: 14,
      icon: "Mug",
      latitude: 40.44320297241211,
      longitude: -79.9428482055664,
      host: "best host",
      people: ["best host", "best attendee"]
    )
    
    let instance3 = Meet(
      title: "asdf",
      location: "The UC",
      startTime: Timestamp(),
      endTime: Timestamp(),
      joined: 2,
      capacity: 14,
      icon: "Mug",
      latitude: 40.44320297241211,
      longitude: -79.9428482055664,
      host: "best host",
      people: ["best host", "best attendee"]
    )
    
    XCTAssertTrue(instance == instance2)
    XCTAssertTrue(instance != instance3)
    let startTimeDate = instance.startTime.dateValue()
    let endTimeDate = instance.endTime.dateValue()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
    XCTAssertTrue(instance.getStartString() == dateFormatter.string(from: startTimeDate))
    XCTAssertTrue(instance.getEndString() == dateFormatter.string(from: endTimeDate))
    XCTAssertTrue(instance3 > instance)
    XCTAssertTrue(instance < instance3)

  }
  
}

