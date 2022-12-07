import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Meet: Codable, Identifiable, Comparable, Hashable {
    @DocumentID var id: String?
    var title: String
    var location: String
    var startTime: Timestamp
    var endTime: Timestamp
    var joined: Int
    var capacity: Int
    var icon: String
    var latitude: Double
    var longitude: Double
    var host: String
    var people : [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case location
        case startTime
        case endTime
        case joined
        case capacity
        case icon
        case latitude
        case longitude
        case host
        case people
    }
    
    static func ==(lhs: Meet, rhs: Meet) -> Bool {
        return lhs.title == rhs.title
    }

    static func <(lhs: Meet, rhs: Meet) -> Bool {
      return lhs.title < rhs.title
    }
    
    func getStartString() -> String {
        let startTimeDate = startTime.dateValue()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: startTimeDate)
    }
    
    func getEndString() -> String {
        let endTimeDate = endTime.dateValue()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        return dateFormatter.string(from: endTimeDate)
    }
}
