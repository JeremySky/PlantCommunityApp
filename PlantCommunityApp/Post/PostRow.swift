import SwiftUI


class PostRowViewModel: ObservableObject {
    @Published var post: Post
    @Published var isLiked: Bool?
    @Published var isBookmarked: Bool?
    @Published var authorUsername: Loadable<String>
    @Published var authorImage: Loadable<UIImage>
    @Published var postImage: Loadable<UIImage>
    @Published var isLoading: Bool
    @Published var alert: CustomAlert?
    
    init(
        post: Post,
        isLiked: Bool? = nil,
        isBookmarked: Bool? = nil,
        authorUsername: Loadable<String> = .loading,
        authorImage: Loadable<UIImage> = .loading,
        postImage: Loadable<UIImage> = .loading,
        isLoading: Bool = true,
        alert: CustomAlert? = nil
    ) {
        self.post = post
        self.isLiked = isLiked
        self.isBookmarked = isBookmarked
        self.authorUsername = authorUsername
        self.authorImage = authorImage
        self.postImage = postImage
        self.isLoading = isLoading
        self.alert = alert
    }
    
    // MARK: - On Appear Functions -
    func getAuthorUsername() {}
    func getAuthorImage() {}
    func getPostImage() {}
    func getIsLiked() {}
    func getIsBookmarked() {}
    
    
    // MARK: - Action Button Functions -
    func toggleIsLiked() {
        guard self.isLiked != nil else { return }
        self.isLiked!.toggle()
    }
    
    func toggleIsBookmarked() {
        guard self.isBookmarked != nil else { return }
        self.isBookmarked!.toggle()
    }
}

struct PostRow: View {
    
    @StateObject var vm: PostRowViewModel
    
    var body: some View {
        // Author Username used in header & caption
        var authorUsername: String {
            switch vm.authorUsername {
            case .loaded(let username):
                return username
            default:
                return "unknown_username"
            }
        }
        
        switch vm.isLoading {
        case true:
            PostRow.placeholder
        case false:
            VStack(spacing: 10) {
                
                // MARK: - Header -
                HStack {
                    // Profile Image
                    switch vm.authorImage {
                    case .loaded(let authorImage):
                        ProfileImageView(authorImage, for: .post)
                    default:
                        ProfileImageView.defaultAvatar(for: .post)
                    }
                    
                    // Username + Hardiness Zone
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
                
                
                // MARK: - Post Image -
                switch vm.postImage {
                case .loaded(let postImage):
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFill()
                        .frame(maxHeight: 500)
                default:
                    // Post Image Error
                    ZStack {
                        Rectangle()
                            .foregroundStyle(.gray.opacity(0.5))
                            .frame(maxHeight: 400)
                        VStack(spacing: 14) {
                            Image(systemName: "exclamationmark.triangle")
                                .foregroundStyle(.orange)
                            Text("Error Loading Image")
                                .foregroundStyle(.primary.opacity(0.6))
                        }
                    }
                }
                
                
                // MARK: - Actions -
                HStack(spacing: 14) {
                    
                    // MARK: - Like Button + Likes Count
                    HStack {
                        
                        // Like Button
                        Button {
                            vm.toggleIsLiked()
                        } label: {
                            Image(systemName: (vm.isLiked ?? false) ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle((vm.isLiked ?? false) ? .red.opacity(0.8) : .primary)
                        }
                        
                        // Likes Count: On tap, display a list of users who liked the post
                        Button("\(vm.post.likesCount)") {}
                        
                    }
                    
                    // MARK: - Comments Button
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
                    
                    // MARK: - Share Button
                    Button {
                        //
                    } label: {
                        Image(systemName: "paperplane")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                    
                    
                    Spacer()
                    
                    
                    // MARK: - Bookmark Button
                    Button {
                        vm.toggleIsBookmarked()
                    } label: {
                        Image(systemName: (vm.isBookmarked ?? false) ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .padding(.horizontal, 2)
                            .frame(width: 24, height: 24)
                            .foregroundStyle((vm.isBookmarked ?? false) ? .blue.opacity(0.8) : .primary)
                    }
                    
                }
                .frame(height: 24)
                .padding(.horizontal)
                .foregroundStyle(.primary)
                
                
                // MARK: - Caption + Timestamp -
                VStack(spacing: 10) {
                    
                    Caption(authorUsername, vm.post.caption)
                    
                    Text(vm.post.timestamp.timeAgo())
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
                
                
            }
            .showCustomAlert(alert: $vm.alert)
        }
        
    }
}





// MARK: - CaptionView -
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





// MARK: - placeholder -
extension PostRow {
    static var placeholder: some View {
        VStack(spacing: 14) {
            // MARK: - Header -
            HStack {
                // Profile Image
                Circle()
                    .frame(width: ProfileImageType.post.size)
                
                // Username + Hardiness Zone
                VStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 280, height: 14)
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 200, height: 12)
                }
                .opacity(0.95)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 50)
            .padding(.horizontal)
            
            // MARK: - Post Image -
            Rectangle()
                .frame(height: 400)
                .opacity(0.6)
            
            
            // MARK: - Action Buttons -
            HStack(spacing: 14) {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 24, height: 24)
                Image(systemName: "bubble")
                    .resizable()
                    .frame(width: 24, height: 24)
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 24, height: 24)
                Spacer()
                Image(systemName: "bookmark")
                    .resizable()
                    .padding(.horizontal, 2)
                    .frame(width: 24, height: 24)
            }
            .frame(height: 24)
            .padding(.horizontal)
            .foregroundStyle(.primary)
            .fontWeight(.semibold)
            
            
            // MARK: - Caption -
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 4)
                        .frame(width: 130, height: 14)
                    RoundedRectangle(cornerRadius: 4)
                        .frame(height: 14)
                }
                
                RoundedRectangle(cornerRadius: 4)
                    .frame(height: 14)
            }
            .padding(.horizontal)
            .opacity(0.8)
            
        }
        .foregroundStyle(.primary.opacity(0.4))
        .shimmering()
    }
}





#Preview {
    @Previewable @StateObject var success = PostRowViewModel(
        post: .generateMock(),
        isLiked: true,
        isBookmarked: true,
        authorUsername: .loaded("LovesTomatoes"),
        authorImage: .loaded(ProfileImageView.dummyAvatarUIImage),
        postImage: .loaded(UIImage(named: "dummy_post_image")!),
        isLoading: false,
        alert: nil
    )
    
    @Previewable @StateObject var failure = PostRowViewModel(
        post: .generateMock(),
        isLiked: true,
        isBookmarked: true,
        authorUsername: .loaded("LovesTomatoes"),
        authorImage: .loaded(ProfileImageView.dummyAvatarUIImage),
        postImage: .failed(URLError(.networkConnectionLost)),
        isLoading: false,
        alert: nil
    )
    
    @Previewable @StateObject var loading = PostRowViewModel(post: .generateMock(), isLoading: true)
    
    
    PostRow(
        vm: success
//        vm: loading
//        vm: failure
    )
}

