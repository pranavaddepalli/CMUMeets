//
//  CurrentUserView.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 11/18/22.
//

import Foundation
import SwiftUI

struct CurrentUserView: View {
    @ObservedObject var firebase: Firebase
    
    var body: some View {
        VStack {
            Text("Name: " + firebase.currentUser.name)
            Text("Phone: " + firebase.currentUser.phone)
            Text("Age: " + String(firebase.currentUser.age))
            Text("Graduation Year: " + String(firebase.currentUser.gradYear))
            Text("Major: " + firebase.currentUser.major)
            Text("Gender: " + firebase.currentUser.gender)
            Text("Pronouns: " + firebase.currentUser.pronouns)
            Text("Ethnicity: " + firebase.currentUser.ethnicity)
        }
    }
}
