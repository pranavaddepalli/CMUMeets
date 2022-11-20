import SwiftUI
import FirebaseFirestoreSwift

struct User: Codable, Identifiable , Comparable {
    @DocumentID var id: String?
    var name: String
    var phone: String
    var major: String
    var gradYear: String
    var age: String
    var gender: String
    var pronouns: String
    var ethnicity: String
    var username: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case phone
        case major
        case gradYear
        case age
        case gender
        case pronouns
        case ethnicity
        case username
    }
    
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name
    }
    
    static func <(lhs: User, rhs: User) -> Bool {
      return lhs.name < rhs.name
    }
}
