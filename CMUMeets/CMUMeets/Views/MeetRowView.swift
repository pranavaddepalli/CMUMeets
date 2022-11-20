//
//  MeetRowView.swift
//  Sprint4
//
//  Created by Isaac Ahn on 11/2/22.
//

import SwiftUI
import Foundation

struct MeetRowView: View {
    @ObservedObject var viewController: ViewController
    
    var meet: Meet
    var body: some View {
        NavigationLink (
            destination: MeetDetailsView(viewController: viewController, meet: meet),
            label: {
                Text(meet.title)
            }
        )
    }
}
