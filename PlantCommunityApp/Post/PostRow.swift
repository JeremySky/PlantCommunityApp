import SwiftUI

class PostRowViewModel: ObservableObject {
    @Published var post: Post
    @Published var isLiked: Bool
    @Published var isBookmarked: Bool
    
    init(
        post: Post,
        isLiked: Bool,
        isBookmarked: Bool
    ) {
        self.post = post
        self.isLiked = isLiked
        self.isBookmarked = isBookmarked
    }
    
    func toggleIsLiked() {
        if isLiked {
            self.isLiked = false
            self.post.likesCount -= 1
        } else {
            self.isLiked = true
            self.post.likesCount += 1
        }
    }
    
    func toggleIsBookmarked() {
        self.isBookmarked.toggle()
    }
}

struct PostRow: View {
    @StateObject var vm: PostRowViewModel
    @State var captionIsExpanded: Bool = false
    let authorUsername: String
    let authorImage: UIImage
    let postImage: UIImage
    
    var body: some View {
        
        VStack(spacing: 14) {
            
            // MARK: -- Header
            HStack {
                Image(uiImage: authorImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 44, height: 44)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                VStack(alignment: .leading) {
                    Text(authorUsername)
                        .font(.headline)
                    if let hardinessZone = vm.post.hardinessZone {
                        Text(hardinessZone.rawValue)
                            .font(.subheadline)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            
            // MARK: -- Content Image
            Image(uiImage: postImage)
                .resizable()
                .scaledToFill()
                .frame(maxHeight: 500)
            
            
            // MARK: -- Actions
            HStack(spacing: 14) {
                HStack {
                    
                    // Like Button
                    Button {
                        vm.toggleIsLiked()
                    } label: {
                        Image(systemName: vm.isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(vm.isLiked ? .red.opacity(0.8) : .primary)
                    }
                    
                    // Likes Count: On tap, display a list of users who liked the post
                    Button("\(vm.post.likesCount)") {}
                    
                }
                Button {
                    //
                } label: {
                    HStack {
                        Image(systemName: "bubble")
                            .resizable()
                            .frame(width: 24, height: 24)
                        Text("\(vm.post.commentCount)")
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
                    vm.toggleIsBookmarked()
                } label: {
                    Image(systemName: vm.isBookmarked ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .padding(.horizontal, 2)
                        .frame(width: 24, height: 24)
                        .foregroundStyle(vm.isBookmarked ? .blue.opacity(0.8) : .primary)
                }
            }
            .frame(height: 20)
            .padding(.horizontal)
            .foregroundStyle(.primary)
            
            
            // MARK: -- Caption
            VStack(spacing: 10) {
                Caption(authorUsername, vm.post.caption)
                
                // Timestamp
                Text(vm.post.timestamp.timeAgo())
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
    }
}


extension PostRow {
    private struct Caption: View {
        
        let authorUsername: String
        let caption: String
        
        @State var isExpanded: Bool = false
        @State var canBeExpanded: Bool = false
        
        init(_ authorUsername: String, _ caption: String) {
            self.authorUsername = authorUsername
            self.caption = caption
            self.isExpanded = false
            self.canBeExpanded = false
        }
        
        var body: some View {
            // Username + Caption
            HStack(spacing: 0) {
                
                (Text((authorUsername) + " ").fontWeight(.bold) + Text(caption))
                    .lineLimit(isExpanded ? nil : 1)
                // Background matches the size of the Text
                    .background {
                        
                        // Pick the first child view that fits vertically
                        ViewThatFits(in: .vertical) {
                            
                            // This Text has no line limit, so if it's is larger than the
                            // "outer" Text, ViewThatFits will pick the next view
                            (Text((authorUsername) + " ").fontWeight(.bold) + Text(caption))
                                .hidden()
                            // Color expands to fill the background, so will always be picked
                            // if the text above is too large
                            Color.clear
                                .onAppear {
                                    canBeExpanded = true
                                }
                        }
                    }
                
                if !isExpanded && canBeExpanded {
                    Button(" more", action: {isExpanded = true})
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray.opacity(0.5))
                        .disabled(isExpanded)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}


#Preview {
    @Previewable @StateObject var vm = PostRowViewModel(
        post: Post.generateMock(),
        isLiked: true,
        isBookmarked: true
    )
    
    let authorUsername: String = "lovesTomatoes"
    let authorImage: UIImage = UIImage(named: "default_avatar")!
    let postImage: UIImage = UIImage(named: "dummy_post_image")!
    
    
    PostRow(
        vm: vm,
        authorUsername: authorUsername,
        authorImage: authorImage,
        postImage: postImage
    )
}
