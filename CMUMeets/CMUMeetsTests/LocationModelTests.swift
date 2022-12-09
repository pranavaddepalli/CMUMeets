//
//  LocationModelTests.swift
//  CMUMeetsTests
//
//  Created by Pranav Addepalli on 12/8/22.
//


import XCTest
@testable import CMUMeets


class LocationModelTests: XCTestCase {
    func testInit() {
        let instance : LocationModel = LocationModel (
          code: "FAKE",
          latitude : 15122,
          longitude : -15122,
          name: "Fake Location"
        )
        
        
       XCTAssertNotNil(instance)
       XCTAssertTrue(instance.code == "FAKE")
       XCTAssertTrue(instance.latitude == 15122)
       XCTAssertTrue(instance.longitude == -15122)
       XCTAssertTrue(instance.name == "Fake Location")
       
       XCTAssertFalse(instance.name == "Real Location")
       XCTAssertFalse(instance.code == "REAL")
       XCTAssertFalse(instance.latitude == 0)
       XCTAssertFalse(instance.longitude == 0)
       
        let copy : LocationModel = LocationModel (
          code: "FAKE",
          latitude : 15122,
          longitude : -15122,
          name: "Fake Location"
        )
        
        let alphabeticallyLater : LocationModel = LocationModel (
          code: "FAKE2",
          latitude : 15122,
          longitude : -15122,
          name: "zzz"
        )
        
        XCTAssertTrue(copy == instance)
        
        XCTAssertTrue(instance != alphabeticallyLater)
        XCTAssertTrue(instance < alphabeticallyLater)
        XCTAssertFalse(instance > alphabeticallyLater)
    }
}
