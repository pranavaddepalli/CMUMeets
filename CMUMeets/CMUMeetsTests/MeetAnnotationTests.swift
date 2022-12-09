//
//  MeetAnnotationTests.swift
//  CMUMeets
//
//  Created by Ricky Lee on 12/8/22.
//

@testable import CMUMeets
import Foundation
import UIKit
import MapKit
import FirebaseFirestore
import XCTest


class MeetAnnotationTests: XCTestCase {
  func testInit() {
    let meet = Meet(title: "World Cup Watching", location: "The UC", startTime: Timestamp(), endTime: Timestamp(), joined: 2, capacity: 14, icon: "Mug", latitude: 40.44320297241211, longitude: -79.9428482055664, host: "", people: [""])
    let meet2 = Meet(title: "Tepper", location: "The UC", startTime: Timestamp(), endTime: Timestamp(), joined: 2, capacity: 14, icon: "Mug", latitude: 40.44320297241211, longitude: -79.9428482055664, host: "", people: [""])
    let firebase = Firebase()
    
    let instance = MeetAnnotation(meet: meet, firebase: firebase)
    
    // Assert Not Nil Tests
    XCTAssertNotNil(instance)
    XCTAssertNotNil(instance.firebase)
    XCTAssertNotNil(instance.meet)
    XCTAssertNotNil(instance.coordinate)
    XCTAssertNotNil(instance.subtitle)
    XCTAssertNotNil(instance.title)
    XCTAssertNotNil(instance.id)
    
    //Assert True Tests
    XCTAssertTrue(instance.meet == meet)
    XCTAssertTrue(instance.coordinate.longitude == CLLocationCoordinate2D(latitude: meet.latitude, longitude: meet.longitude).longitude)
    XCTAssertTrue(instance.coordinate.latitude == CLLocationCoordinate2D(latitude: meet.latitude, longitude: meet.longitude).latitude)
    XCTAssertTrue(instance.subtitle == "The UC")
    XCTAssertTrue(instance.title == "World Cup Watching")
    
    //Assert False Tests
//    XCTAssertTrue(instance.firebase == firebase)
    XCTAssertFalse(instance.meet == meet2)
    XCTAssertFalse(instance.coordinate.longitude == CLLocationCoordinate2D(latitude: meet.latitude, longitude: meet.longitude).latitude)
    XCTAssertFalse(instance.coordinate.latitude == CLLocationCoordinate2D(latitude: meet.latitude, longitude: meet.longitude).longitude)
    XCTAssertFalse(instance.subtitle == "The Fence")
    XCTAssertFalse(instance.title == "Eating Lunch")

  }
}
