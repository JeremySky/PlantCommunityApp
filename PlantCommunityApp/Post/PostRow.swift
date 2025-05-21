import SwiftUI

class PostRowViewModel: ObservableObject {
    @Published var post: Post
    @Published var authorUsername: String?
    @Published var authorImage: UIImage?
    @Published var isLiked: Bool?
    @Published var isBookmarked: Bool?
    @Published var lineLimit: Int?
    
    
    init(post: Post,
         authorUsername: String? = nil,
         authorImage: UIImage? = nil,
         isLiked: Bool? = nil,
         isBookmarked: Bool? = nil,
         lineLimit: Int? = nil
    ) {
        self.post = post
        self.authorUsername = authorUsername
        self.authorImage = authorImage
        self.isLiked = isLiked
        self.isBookmarked = isBookmarked
        self.lineLimit = lineLimit
    }
}

struct PostRow: View {
    @StateObject var vm: PostRowViewModel
    
    var body: some View {
        
        VStack(spacing: 14) {
            
            if let authorUsername = vm.authorUsername,
               let authorImage = vm.authorImage,
               let isLiked = vm.isLiked,
               let isBookmarked = vm.isBookmarked
            {
                
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
                AsyncImage(url: URL(string: vm.post.imageURL ?? "")) { image in
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
                
                
                // MARK: -- Actions
                HStack(spacing: 14) {
                    HStack {
                        
                        // Like Button
                        Button {
                            vm.isLiked!.toggle()
                        } label: {
                            Image(systemName: isLiked ? "heart.fill" : "heart")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(isLiked ? .red.opacity(0.8) : .primary)
                        }
                        
                        // Likes Count: On tap, display a list of users who liked the post
                        Button("\(vm.post.likesCount)", action: {})
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
                        vm.isBookmarked!.toggle()
                    } label: {
                        Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                            .resizable()
                            .padding(.horizontal, 2)
                            .frame(width: 24, height: 24)
                            .foregroundStyle(isBookmarked ? .blue.opacity(0.8) : .primary)
                    }
                }
                .frame(height: 20)
                .padding(.horizontal)
                .foregroundStyle(.primary)
                
                
                // MARK: -- Caption
                VStack(spacing: 10) {
                    
                    // Username + Caption
                    HStack(spacing: 0) {
                        (Text((vm.authorUsername ?? "") + " ").fontWeight(.bold) + Text(vm.post.caption))
                            .lineLimit(vm.lineLimit)
                        if vm.lineLimit == 1 {
                            Button(" more", action: {vm.lineLimit = nil})
                                .fontWeight(.semibold)
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // Timestamp
                    Text(vm.post.timestamp.timeAgo())
                        .foregroundStyle(.gray)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
            } else {
                
                HStack {
                    Circle()
                        .frame(width: 44, height: 44)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 15)
                        .padding(.trailing, 150)
                }
                .padding()
                
                Rectangle()
                    .frame(height: 500)
                
                VStack {
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 15)
                    RoundedRectangle(cornerRadius: 20)
                        .frame(height: 15)
                }
                .padding()
            }
        }
    }
}


#Preview {
    @Previewable @StateObject var vm = PostRowViewModel(
        post: Post.generateMock(),
        authorUsername: "lovesTOMATO",
        authorImage: UIImage(named: "default_avatar_256x256"),
        isLiked: true,
        isBookmarked: true,
        lineLimit: 1
    )
    
    PostRow(vm: vm)
}
