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
    let expired: TimeInterval = 5.0

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
        // MARK: NEED to use a real meet from firestore to try to join
        
//        defer { waitForExpectations(timeout: expired) }
//        let exampleMeet = Meet(title: "more code testing",
//                               location: "Wean Hall",
//                               startTime: Timestamp(),
//                               endTime: Timestamp(),
//                               joined: 1,
//                               capacity: 2,
//                               icon: "fake icon",
//                               latitude: 0,
//                               longitude: 0,
//                               host: "id",
//                               people: ["person id 1"]
//                            )
//        
//        let res = firebase.joinMeet(meet: exampleMeet)
//        
//        // check not nil
//        XCTAssertNotNil(res)
//        // check corect value
//        XCTAssert(res == "Successfully joined meet!")
//        self.e.fulfill()
        
    }
}
