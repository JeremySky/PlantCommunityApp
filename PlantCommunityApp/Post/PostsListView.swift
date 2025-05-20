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
                        PostRow(post)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview {
    PostsListView(posts: Post.samplePosts)
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







//    VStack {
//        HStack {
//            Circle()
//                .frame(width: 44, height: 44)
//            RoundedRectangle(cornerRadius: 20)
//                .frame(height: 15)
//                .padding(.trailing, 150)
//        }
//        .padding()
//        
//        Rectangle()
//            .frame(height: 500)
//        
//        VStack {
//            RoundedRectangle(cornerRadius: 20)
//                .frame(height: 15)
//            RoundedRectangle(cornerRadius: 20)
//                .frame(height: 15)
//        }
//        .padding()
//    }


/// Image Loading Error View
//    ZStack {
//        Rectangle()
//            .frame(height: 500)
//            .foregroundStyle(.gray.opacity(0.4))
//        VStack {
//            Image(systemName: "exclamationmark.triangle.fill")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 40)
//                .foregroundStyle(Color.red.opacity(0.9))
//            Text("Unable to load image")
//        }
//    }
