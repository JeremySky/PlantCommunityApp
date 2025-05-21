import SwiftUI

struct PostsListView: View {
    @State var posts: [Post]
    @State var isLoading: Bool = false
    var body: some View {
        ScrollView(showsIndicators: false) {
            if isLoading {
//                PostRow(Post.loading())
            } else {
                VStack(spacing: 60) {
                    ForEach(posts) { post in
                        PostRow(vm: PostRowViewModel(post: post, isLiked: false, isBookmarked: false), authorUsername: "ASDFASDF", authorImage: UIImage(named: "default_avatar")!, postImage: UIImage(named: "dummy_post_image")!)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    PostsListView(posts: Array(repeating: Post.generateMock(), count: 4))
}
#endif


extension Date {
    func timeAgo() -> String {
        let now = Date()
        let secondsAgo = now.timeIntervalSince(self)
        let oneHour: TimeInterval = 3600
        let oneDay: TimeInterval = 86400
        let oneWeek: TimeInterval = oneDay * 7

        if secondsAgo < oneHour {
            return "Just now"
        } else if secondsAgo < oneWeek {
            let formatter = RelativeDateTimeFormatter()
            formatter.unitsStyle = .full
            return formatter.localizedString(for: self, relativeTo: now)
        } else {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .none
            return formatter.string(from: self)
        }
    }
}







