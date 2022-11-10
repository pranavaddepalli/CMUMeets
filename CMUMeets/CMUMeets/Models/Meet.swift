//
//  Meet.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Meet: Codable, Identifiable , Comparable {
    @DocumentID var id: String?
    var title: String
    var location: String
    var timeStart: Timestamp
    var timeEnd: Timestamp
    var host: User
    var people: [User]
    var capacity: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case timeStart
        case timeEnd
        case host
        case people
        case capacity
    }

    static func ==(lhs: Meet, rhs: Meet) -> Bool {
        return lhs.title == rhs.title && lhs.host == rhs.host
    }

    static func <(lhs: Meet, rhs: Meet) -> Bool {
      return lhs.title < rhs.title
    }
    
    func getStartString() -> String {
        let timeStartDate = timeStart.dateValue()
        
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
