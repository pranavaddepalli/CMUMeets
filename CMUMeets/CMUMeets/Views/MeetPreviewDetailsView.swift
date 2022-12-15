
import Foundation
import SwiftUI
import FirebaseFirestore

struct MeetPreviewDetailsView: View {
    @ObservedObject var firebase: Firebase
    
    var meet: Meet
    @State private var clicked: Bool = false
    @State private var alertShown = false
    @State private var alert2Shown = false

    
    
    var body: some View {
        VStack {
            Text("Hosted by: " + (firebase.users[meet.host]?.name ?? "unknown"))
            Text("Host's Phone: " + (firebase.users[meet.host]?.phone ?? "unknown"))
            
            
        }
        HStack{
            Text("Start: " + meet.getStartString().split(separator: " ")[1])
            Text("End: " + meet.getEndString().split(separator: " ")[1])
            
                .padding()
        }
        Text("Joined: " + String(meet.joined) + "/" + String(meet.capacity))
        
        HStack {
            ForEach(meet.people, id: \.self) {p in
                VStack{
                    Text("🧍" + (firebase.users[p]?.name ?? "unknown"))}
            }
        }.padding()
        Spacer()
        
    }
}
