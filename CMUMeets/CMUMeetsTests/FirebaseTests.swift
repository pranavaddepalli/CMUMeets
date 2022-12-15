//
//  FirebaseTests.swift
//  CMUMeetsTests
//
//  Created by Pranav Addepalli on 12/8/22.
//

import XCTest
import Foundation
import FirebaseFirestore


@testable import CMUMeets

class FirebaseTests : XCTestCase {
  var firebase : Firebase!
  var e: XCTestExpectation!
  let expired: TimeInterval = 5.0
  
  override func setUp() {
    print("beginning a test")
    e = expectation(description: "Firebase operations work correctly")
    firebase = Firebase()
  }
  
  override func tearDown() {
    print("ending a test")
  }
  
  
  
  func testUpdatedMeets() {
    defer { waitForExpectations(timeout: expired) }
    
    let res = firebase.updatedMeets()
    
    // check not nil
    XCTAssertNotNil(res)
    // check corect value
    XCTAssert(res == "success: updated meets")
    self.e.fulfill()
    
  }
  
  func testUpdatedUsers() {
    defer { waitForExpectations(timeout: expired) }
    
    var res = firebase.updatedUsers()
    // check not nil
    XCTAssertNotNil(res)
    // check corect value
    XCTAssert(res == "success: updated users")
    
    firebase.db.collection("meets").document("EXAMPLEMEETID").setData([
      "title" : "JoinMeetTest",
      "icon" : "Fake icon",
      "joined" : 1,
      "host" : "not my id",
      "capacity" : 2,
      "location" : "We found it",
      "latitude" : 0,
      "longitude" : 0,
      "startTime" : Date(),
      "endTime" : Date().advanced(by: 1000),
      "people" : ["not my id"]
    ]) { err in
      if let err = err {
        print("Error writing meet: \(err)")
        XCTAssert(false)
      }
    }
    
    res = firebase.updatedUsers()
    
    // check not nil
    XCTAssertNotNil(res)
    // check corect value
    XCTAssert(res == "success: updated users")
    
    self.e.fulfill()
    
  }
  
  func testUpdatedLocations() {
    defer { waitForExpectations(timeout: expired) }
    
    // update one of the locations
    firebase.db.collection("locations").document("AH").updateData([
      "name": "Not Alumni House"
    ])
    
    var res = firebase.updatedLocations() { newLocs in
      for loc in newLocs {
        // check not nil
        XCTAssertNotNil(loc)
        // check corect value
        XCTAssert(Array(self.firebase.locations.values).contains(loc))
      }
    }
    
    self.e.fulfill()
    
  }
  
  func testHostMeet() {
    defer { waitForExpectations(timeout: expired) }
    let loc = LocationModel (
      code: "FENCE",
      latitude : 40.4432027,
      longitude : -79.9428499,
      name: "The Fence"
    )
    
    let res = firebase.hostMeet(meetName: "testing the code", icon: "fake icon", capacity: 2, loc: loc, start: Date.now, end: Date.now.advanced(by: 1800) )
    
    // check not nil
    XCTAssertNotNil(res)
    // check corect value
    XCTAssert(res == "Successfully hosted your Meet!")
    
    var fail = firebase.hostMeet(meetName: "", icon: "fake icon", capacity: 2, loc: loc, start: Date.now, end: Date.now.advanced(by: 1800) )
//    XCTAssertNotNil(fail)
//    XCTAssert(fail == "Give your Meet a good name.")
    
    fail = firebase.hostMeet(meetName: "asdf", icon: "fake icon", capacity: 1, loc: loc, start: Date.now, end: Date.now.advanced(by: 1800) )
    XCTAssertNotNil(fail)
    XCTAssert(fail == "You can't Meet with less than 2 people!")
    
    fail = firebase.hostMeet(meetName: "asdf", icon: "fake icon", capacity: 2, loc: loc, start: Date.now.advanced(by: 2000), end: Date.now.advanced(by: 1800) )
    XCTAssertNotNil(fail)
    XCTAssert(fail == "End time must be after start time.")
    
    self.e.fulfill()
    
  }
  
  func testJoinMeet() {
    defer { waitForExpectations(timeout: expired) }
    
    // host a meet first
    let exampleMeetID = "EXAMPLEMEETID"
    
    firebase.db.collection("meets").document(exampleMeetID).setData([
      "title" : "JoinMeetTest",
      "icon" : "Fake icon",
      "joined" : 1,
      "host" : "not my id",
      "capacity" : 2,
      "location" : "Nowhere to be found",
      "latitude" : 0,
      "longitude" : 0,
      "startTime" : Date(),
      "endTime" : Date().advanced(by: 1000),
      "people" : ["not my id"]
    ]) { err in
      if let err = err {
        print("Error writing meet: \(err)")
        XCTAssert(false)
      }
    }
    
    let docRef = firebase.db.collection("meets").document(exampleMeetID)
    
    
    docRef.getDocument(as: Meet.self) { result in
      switch result {
      case .success(let m):
        let res = self.firebase.joinMeet(meet: m)
        // check not nil
        XCTAssertNotNil(res)
        // check correct value
        XCTAssert(res == "Successfully joined meet!")
        
      case .failure(let error):
        print("Error decoding meet: \(error)")
        XCTAssert(false)
      }
      
    }
    self.e.fulfill()

  }
  
  func testLeaveMeet(){
    defer { waitForExpectations(timeout: expired) }
    
    
    // host a meet first
    let exampleMeetID = "EXAMPLEMEETID"
    
    firebase.db.collection("meets").document(exampleMeetID).setData([
      "title" : "JoinMeetTest",
      "icon" : "Fake icon",
      "joined" : 1,
      "host" : "not my id",
      "capacity" : 2,
      "location" : "Nowhere to be found",
      "latitude" : 0,
      "longitude" : 0,
      "startTime" : Date(),
      "endTime" : Date().advanced(by: 1000),
      "people" : ["not my id"]
    ]) { err in
      if let err = err {
        print("Error writing meet: \(err)")
        XCTAssert(false)
      }
    }
    
    let docRef = firebase.db.collection("meets").document("EXAMPLEMEETID")
    
    docRef.getDocument(as: Meet.self) { result in
      switch result {
      case .success(let m):
        let res = self.firebase.leaveMeet(meet: m)
        // check not nil
        XCTAssertNotNil(res)
        // check correct value
        print(res)
        XCTAssert(res == "Meet successfully left!")
        
      case .failure(let error):
        print("Error decoding meet: \(error)")
        XCTAssert(false)
      }
    }
    
    self.e.fulfill()

  }
  
  func testDeleteMeet(){
    defer { waitForExpectations(timeout: expired) }

    // host a meet first
    let exampleMeetID = "EXAMPLEMEETID"

    firebase.db.collection("meets").document(exampleMeetID).setData([
      "title" : "JoinMeetTest",
      "icon" : "Fake icon",
      "joined" : 1,
      "host" : "not my id",
      "capacity" : 2,
      "location" : "Nowhere to be found",
      "latitude" : 0,
      "longitude" : 0,
      "startTime" : Date(),
      "endTime" : Date().advanced(by: 1000),
      "people" : ["not my id"]
    ]) { err in
      if let err = err {
        print("Error writing meet: \(err)")
        XCTAssert(false)
      }
    }

    let docRef = firebase.db.collection("meets").document("EXAMPLEMEETID")

    docRef.getDocument(as: Meet.self) { result in
      switch result {
      case .success(let m):
        let res = self.firebase.deleteMeet(meet: m)
        // check not nil
        XCTAssertNotNil(res)
        // check correct value
        print(res)
        XCTAssert(res == "Meet successfully removed!")

      case .failure(let error):
        print("Error decoding meet: \(error)")
        XCTAssert(false)
      }
    }
    
    self.e.fulfill()

  }
}
