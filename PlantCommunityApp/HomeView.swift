import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MainFeedView()
            ForYouView()
            ProfileView()
        }
    }
}

#Preview {
    MainView()
}
