import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

struct MeetDetails: View {
    @ObservedObject var meetsLibraryViewModel: MeetsLibraryViewModel
    @ObservedObject var viewController: ViewController
    var currentTimestamp: Timestamp = Timestamp()
    
    var body: some View {
        NavigationView {
            List{
                Section ("Ongoing Meets") {
                    let meetViewModels = meetsLibraryViewModel.meetViewModels.sorted(by: { $0.meet < $1.meet })
                    ForEach(meetViewModels) { meetViewModel in
                        if meetViewModel.meet.getEndString() > getCurrentDate() {
                            MeetRowView(viewController: viewController, meet: meetViewModel.meet)
                        }
                    }
                }
                Section ("Joined Meets") {
                    ForEach(viewController.ongoingMeets) { meet in
                        MeetRowView(viewController: viewController, meet: meet)
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

