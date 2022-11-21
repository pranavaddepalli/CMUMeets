//
//  MeetRowView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI
import Foundation
import FirebaseFirestore

struct MeetRowView: View {
    @ObservedObject var firebase: Firebase
    
    var meet: Meet
    var body: some View {
        NavigationLink (
            destination: MeetDetailsView(firebase: firebase, meet: meet),
            label: {
                Text(meet.title)
            }
        )
    }
}
