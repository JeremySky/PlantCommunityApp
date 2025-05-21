import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            //PostsView
            Tab("Posts", systemImage: "house.fill") {
                Text("PostsView")
            }
            //BlogsView
            Tab("Blogs", systemImage: "book.fill") {
                Text("BlogsView")
            }
            //NewContent
            Tab("New Content", systemImage: "plus") {
                Text("NewContentVew")
            }
            //ProfileView
            Tab("Profile", systemImage: "person.circle") {
                Text("ProfileView")
            }
        }
    }
}

#Preview {
    HomeView()
}
