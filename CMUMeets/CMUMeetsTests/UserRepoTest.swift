//
//  UserRepoTest.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 12/8/22.


import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import XCTest

class UserRepoTests: XCTestCase {
    func testInit() {
        let userRepo = UsersRepository()
        
        //Test to see if Repo reads from Firebase
        XCTAssertNotNil(userRepo.users)
        
    }
    
}
