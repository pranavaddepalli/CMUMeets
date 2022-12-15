//
//  MeetListView.swift
//  CMUMeets
//
//  Created by Pranav Addepalli on 12/14/22.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeetList: View {
    @ObservedObject var firebase: Firebase
    var currentTimestamp: Timestamp = Timestamp()
    @State var updater: Bool = false
    
    var body: some View {
        NavigationView {
            List{
              Section ("Meets Around Me") {
                ForEach(Array(firebase.meets.values), id: \.self) { meet in
                    if (meet.getEndString() > getCurrentDate() && !firebase.joinedMeets.contains(meet)) {
                    MeetRowView(firebase: firebase, meet: meet)
                  }
                }
              }
              Section ("My Meets") {
                ForEach(firebase.meets.values.filter( {$0.people.contains(firebase.currentUser.id!)} ).sorted(by: {$0.endTime.dateValue() > $1.endTime.dateValue()} ), id: \.self) { meet in
                  if (meet.getEndString() > getCurrentDate()){
                    MeetRowView(firebase: firebase, meet: meet)
                  }
                }
              }
            }.navigationBarTitle("Meets")
        }
    }
    
    func getCurrentDate() -> String {
        let currentDatevalue = currentTimestamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let currentTime = dateFormatter.string(from: currentDatevalue)
        return currentTime
    }
}

