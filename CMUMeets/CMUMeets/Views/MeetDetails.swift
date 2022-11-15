import SwiftUI

struct MeetDetails: View {
    @ObservedObject var meetsLibraryViewModel = MeetsLibraryViewModel()
      
    var body: some View {
        NavigationView {
            List{
                let meetViewModels = meetsLibraryViewModel.meetViewModels.sorted(by: { $0.meet < $1.meet })
                ForEach(meetViewModels) { meetViewModel in
                    MeetRowView(meet: meetViewModel.meet)
                }
            }.navigationBarTitle("Meets")
        }
    }
    
}

struct MeetDetails_Previews: PreviewProvider {
    static var previews: some View {
        MeetDetails()
    }
}
