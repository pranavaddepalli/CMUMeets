//
//  CurrentUser.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/10/22.
//

import Foundation
import SwiftUI

struct CurrentUser: View {
    var currentUser: User = User(name: "Isaac Ahn", phone: "1123456789", major: "Information Systems", gradYear: 2023, age: 21, gender: "Male", pronouns: "He/Him", ethnicity: "Asian", username: "iya")
    
    var body: some View {
        VStack {
            Text("Current User")
            Text("Name: " + currentUser.name)
            Text("Phone: " + currentUser.phone)
            Text("Major: " + currentUser.major)
            Text("Graduation Year: " + String(currentUser.gradYear))
            Text("Age: " + String(currentUser.age))
            Text("Gender: " + currentUser.gender)
            Text("Pronouns: " + currentUser.pronouns)
            Text("Ethnicity: " + currentUser.ethnicity)
            Text("Username: " + currentUser.username)
        }
    }
}
