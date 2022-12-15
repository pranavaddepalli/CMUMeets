//
//  UserTests.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 12/14/22.
//

import XCTest
import Firebase

@testable import CMUMeets

class UserTests: XCTestCase {
 func testInit() {
   let instance = User(name: "Isaac Ahn", phone: "1123456789", major: "Information Systems", gradYear: "2023", age: "21", gender: "Male", pronouns: "He/Him", ethnicity: "Asian", username: "Iya")
   
   let instance2 = User(name: "Pranav Addepalli", phone: "1123456789", major: "Information Systems", gradYear: "2024", age: "21", gender: "Male", pronouns: "He/Him", ethnicity: "Asian", username: "P")


   XCTAssertNotNil(instance)
   XCTAssertNotNil(instance.name)
   XCTAssertNotNil(instance.phone)
   XCTAssertNotNil(instance.gradYear)
   XCTAssertNotNil(instance.major)
   XCTAssertNotNil(instance.age)
   XCTAssertNotNil(instance.gender)
   XCTAssertNotNil(instance.pronouns)
   XCTAssertNotNil(instance.ethnicity)
   XCTAssertNotNil(instance.username)

   //Assert True Tests
   XCTAssertTrue(instance.name == "Isaac Ahn")
   XCTAssertTrue(instance.phone == "1123456789")
   XCTAssertTrue(instance.gradYear == "2023")
   XCTAssertTrue(instance.major == "Information Systems")
   XCTAssertTrue(instance.age == "21")
   XCTAssertTrue(instance.gender == "Male")
   XCTAssertTrue(instance.pronouns == "He/Him")
   XCTAssertTrue(instance.ethnicity == "Asian")
   XCTAssertTrue(instance.username == "Iya")


   //Assert False Tests
   XCTAssertFalse(instance.name == "Ricky Lee")
   XCTAssertFalse(instance.phone == "1234567890")
   XCTAssertFalse(instance.gradYear == "2021")
   XCTAssertFalse(instance.major == "Computer Science")
   XCTAssertFalse(instance.age == "11")
   XCTAssertFalse(instance.gender == "Prefer not to say")
   XCTAssertFalse(instance.pronouns == "She/Her")
   XCTAssertFalse(instance.ethnicity == "Hispanic")
   XCTAssertFalse(instance.username == "rickyl")
   
   
   XCTAssertTrue(instance != instance2)
   XCTAssertTrue(instance < instance2)

 }
}
