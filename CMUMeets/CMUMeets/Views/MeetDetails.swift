import Foundation
import SwiftUI
import FirebaseFirestore

struct MeetDetailsView: View {
    @State var meet: Meet
    @State private var clicked: Bool = false
    @State private var presentAlert = false
    @State private var meetsRepo = MeetsRepository()
    
    var body: some View {
        VStack {
            Text(meet.title)
            Text("Location: " + meet.location)
            Text("Start: " + meet.getStartString())
            Text("End: " + meet.getEndString())
            Text("Joined: " + String(meet.joined))
            Text("Capacity: " + String(meet.capacity))
            Button("JOIN MEET") {
                if meet.joined < meet.capacity {
                    joinMeet()
                    clicked = true
                }
                else {
                    presentAlert = true
                }
            }
            .alert("This Meet is full!", isPresented: $presentAlert, actions:{})
            .disabled(clicked)
        }
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
    }
}
