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
    var e: XCTestExpectation!
    let firebase = Firebase()
    let expired: TimeInterval = 10.0

    override func setUp() {
      e = expectation(description: "Firebase operations work correctly")
    }
    
    func testReadUsers() {
        defer { waitForExpectations(timeout: expired) }
        
        let res = firebase.readUsers()
        
        // check not nil
        XCTAssertNotNil(res)
        // check corect value
        XCTAssert(res == "success: users")
        self.e.fulfill()
        
    }
    
    func testReadLocations() {
        defer { waitForExpectations(timeout: expired) }
        
        let res = firebase.readLocations()
        
        // check not nil
        XCTAssertNotNil(res)
        // check corect value
        XCTAssert(res == "success: locations")
        self.e.fulfill()
        
    }
    
    func testReadMeets() {
        defer { waitForExpectations(timeout: expired) }
        
        let res = firebase.readMeets()
        
        // check not nil
        XCTAssertNotNil(res)
        // check corect value
        XCTAssert(res == "success: meets")
        self.e.fulfill()
        
    }
    
    func tesetUpdatedMeets() {
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
        
        let res = firebase.updatedUsers()
        
        // check not nil
        XCTAssertNotNil(res)
        // check corect value
        XCTAssert(res == "success: updated users")
        self.e.fulfill()
        
    }
    
    func testUpdatedLocations() {
        defer { waitForExpectations(timeout: expired) }
        
        let res = firebase.updatedLocations()
        
        // check not nil
        XCTAssertNotNil(res)
        // check corect value
        XCTAssert(res == "success: updated locations")
        self.e.fulfill()
        
    }
    
    func testHostMeet() {
        defer { waitForExpectations(timeout: expired) }
        
        let res = firebase.hostMeet(meetName: "testing the code", icon: "fake icon", capacity: 2, loc: LocationModel (
            code: "FENCE",
            latitude : 40.4432027,
            longitude : -79.9428499,
            name: "The Fence"
        ), start: Date.now, end: Date.now.advanced(by: 1800) )
        
        // check not nil
        XCTAssertNotNil(res)
        // check corect value
        XCTAssert(res == "Successfully hosted your Meet!")
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
        "endTime" : Date().advanced(by: 1000)
        "people" : ["not my id"]
      ]) { err in
        if let err = err {
          print("Error writing meet: \(err)")
        }
      }
      
      let docRef = firebase.db.collection("meets").document(exampleMeetID)
      
      
      docRef.getDocument(as: Meet.self) { result in
          // The Result type encapsulates deserialization errors or
          // successful deserialization, and can be handled as follows:
          //
          //      Result
          //        /\
          //   Error  Meet
          switch result {
          case .success(let m):
            
            let res = self.firebase.joinMeet(meet: m)
            // check not nil
            XCTAssertNotNil(res)
            // check corect value
            XCTAssert(res == "Successfully joined meet!")
            self.e.fulfill()

          case .failure(let error):
              // A `City` value could not be initialized from the DocumentSnapshot.
              print("Error decoding meet: \(error)")
              XCTAssert(false)
          }
      }
      
        
    }
}
