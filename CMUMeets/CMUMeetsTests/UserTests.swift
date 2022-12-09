//
//  UserTests.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 12/8/22.
//

import XCTest
import Firebase

class UserTests: XCTestCase {
 func testInit() {
     let instance = User(name: "Isaac Ahn", phone: "1123456789", major: "Information Systems", gradYear: "2023", age: "21", gender: "Male", pronouns: "He/Him", ethnicity: "Asian", username: "Iya")


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

   //Tests for Functions
   let dictInstance: [String: String] = instance.toAnyObject()
   XCTAssertTrue(dictInstance["name"] == instance.name)
   XCTAssertTrue(dictInstance["phone"] == instance.phone)
   XCTAssertTrue(dictInstance["gradYear"] == instance.gradYear)
   XCTAssertTrue(dictInstance["major"] == instance.major)
   XCTAssertTrue(dictInstance["age"] == instance.age)
   XCTAssertTrue(dictInstance["gender"] == instance.gender)
   XCTAssertTrue(dictInstance["pronouns"] == instance.pronouns)
   XCTAssertTrue(dictInstance["ethnicity"] == instance.ethnicity)
   XCTAssertTrue(dictInstance["username"] == instance.username)

 }
}
