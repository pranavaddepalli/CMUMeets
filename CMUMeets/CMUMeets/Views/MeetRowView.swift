//
//  MeetRowView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI
import Foundation

struct MeetRowView: View {
    var meet: Meet
    var body: some View {
        NavigationLink (
            destination: MeetDetailsView(meet: meet),
            label: {
                Text(meet.title)
            }
        )
    }
}
