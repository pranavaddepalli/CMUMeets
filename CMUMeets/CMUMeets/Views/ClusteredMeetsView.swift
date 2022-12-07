//
//  ClusteredMeetsView.swift
//  Sprint4
//
//  Created by Ricky Lee on 12/5/22.
//
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import MapKit

struct ClusteredMeetsView: View {
    var annotations : Array<MeetAnnotation>

    var body: some View {
        NavigationStack {
            List{
              ForEach(annotations, id: \.meet.title) { annotation in
                  MeetRowView(firebase: annotation.firebase, meet: annotation.meet)
              }
            }
        }
    }
}
