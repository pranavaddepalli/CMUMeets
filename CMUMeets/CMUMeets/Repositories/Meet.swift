//
//  Meet.swift
//  CMUMeets
//
//  Created by Ricky Lee on 11/9/22.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Meet: Codable, Identifiable , Comparable {
    @DocumentID var id: String?
    var title: String
    var location: String
    var timeStart: Timestamp
    var timeEnd: Timestamp
    var joined: Int
    var capacity: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case timeStart
        case timeEnd
        case joined
        case capacity
    }

    static func ==(lhs: Meet, rhs: Meet) -> Bool {
        return lhs.title == rhs.title
    }

    static func <(lhs: Meet, rhs: Meet) -> Bool {
      return lhs.title < rhs.title
    }
    
    func getStartString() -> String {
        let timeStartDate = timeStart.dateValue()
        print(timeStartDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: timeStartDate)
    }
    
    func getEndString() -> String {
        let timeEndDate = timeEnd.dateValue()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: timeEndDate)
    }
}

