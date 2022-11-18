//
//  CurrentUserView.swift
//  CMUMeets
//
//  Created by Isaac Ahn on 11/18/22.
//

import Foundation
import SwiftUI

struct CurrentUserView: View {
    @ObservedObject var viewController: ViewController = ViewController()
    
    var body: some View {
        VStack {
            Text("Name: " + viewController.currentUser.name)
            Text("Phone: " + viewController.currentUser.phone)
            Text("Age: " + String(viewController.currentUser.age))
            Text("Graduation Year: " + String(viewController.currentUser.gradYear))
            Text("Major: " + viewController.currentUser.major)
            Text("Gender: " + viewController.currentUser.gender)
            Text("Pronouns: " + viewController.currentUser.pronouns)
            Text("Ethnicity: " + viewController.currentUser.ethnicity)
        }
    }
}
