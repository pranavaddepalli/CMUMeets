
import Foundation
import SwiftUI
import FirebaseFirestore

struct MeetPreviewDetailsView: View {
    @ObservedObject var firebase: Firebase
    
    var meet: Meet
    @State private var clicked: Bool = false
    @State private var alertShown = false
    
    var body: some View {
        Text("@ " + meet.location)
        Text("Start: " + meet.getStartString())
        Text("End: " + meet.getEndString())
        Text("Joined: " + String(meet.joined) + "/" + String(meet.capacity))
        Button(action:  {
            if meet.joined < meet.capacity {
                joinMeet()
                clicked = true
            }
            else {
                alertShown = true
            }
            
        }) {
            Text("Join Meet")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60)
                .background(Color.green)
                .cornerRadius(15.0)
        }
        .disabled(clicked)
        .alert("This Meet is Full!", isPresented: $alertShown, actions: {})
    }
    
    func joinMeet() {
        let db = Firestore.firestore()
        let path = db.collection("meets").document(self.meet.id!)
        path.updateData([
            "joined": meet.joined + 1
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            }
            else {
                print("Document updated successfully")
            }
        }
        self.firebase.ongoingMeets.append(meet)
    }
}