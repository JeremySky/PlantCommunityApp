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


struct PostRow: View {
    @State var post: Post
    
    init(_ post: Post) { self.post = post }
    
    var body: some View {
        VStack(spacing: 14) {
            /// Post Header
            HStack {
                AsyncImage(url: URL(string: post.authorImageURL ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                } placeholder: {
                    Circle()
                        .frame(width: 44, height: 44)
                }
                VStack(alignment: .leading) {
                    Text(post.authorUsername ?? "Unknown User")
                        .font(.headline)
                    Text(post.hardinessZone.rawValue)
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            /// Post Image
            AsyncImage(url: URL(string: post.imageURL ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxHeight: 500)
            } placeholder: {
                Rectangle()
                    .frame(height: 500)
                    .foregroundStyle(.gray.opacity(0.4))
                    .shimmering()
            }
            
            /// Actions
            HStack(spacing: 14) {
                HStack {
                    Button {
                        post.isLiked.toggle()
                    } label: {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(post.isLiked ? .red.opacity(0.8) : .primary)
                    }
                    Button("\(post.likesCount)", action: {})
                }
                Button {
                    //
                } label: {
                    HStack {
                        Image(systemName: "bubble")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("\(post.commentCount)")
                    }
                }
                Button {
                    //
                } label: {
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
                Spacer()
                
                Button {
                    post.isBookmarked.toggle()
                } label: {
                    Image(systemName: post.isBookmarked ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .padding(.horizontal, 2)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(post.isBookmarked ? .blue.opacity(0.8) : .primary)
                }
            }
            .frame(height: 20)
            .padding(.horizontal)
            .foregroundStyle(.primary)
            
            /// Caption
            VStack(spacing: 10) {
                HStack(spacing: 0) {
                    (Text((post.authorUsername ?? "") + " ").fontWeight(.bold) + Text(post.caption))
                        .lineLimit(post.lineLimit)
                    if post.lineLimit == 1 {
                        Button(" more", action: {post.lineLimit = nil})
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray.opacity(0.5))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                /// Timestamp
                Text(post.timestamp.timeAgo())
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
    }
}

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
