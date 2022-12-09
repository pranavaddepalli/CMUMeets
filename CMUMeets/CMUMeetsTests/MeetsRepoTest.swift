//
//  MeetsRepoTest.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 12/8/22.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import XCTest

class MeetRepoTests: XCTestCase {
    let meetRepo = MeetsRepository()
    
    func testInit() {
        //Test to see if Repo reads from Firebase
        XCTAssertNotNil(meetRepo.meets)
        
    }
    
}
