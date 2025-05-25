import SwiftUI

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
                        ProfileImage(authorImage, for: .post)
                    default:
                        ProfileImage.defaultAvatar(for: .post)
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
                
                
                // MARK: - Post Content -
                switch vm.postImage {
                case .loaded(let postImage):
                    
                    
                    // Image
                    if let postImage {
                        Image(uiImage: postImage)
                            .resizable()
                            .scaledToFill()
                            .frame(maxHeight: 500)
                        
                    // Caption + Timestamp
                    } else /*if nil*/ {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(vm.post.caption)
                            
                            Text(vm.post.timestamp.timeAgo())
                                .foregroundStyle(.gray)
                                .font(.caption)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    }
                    
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
                
                
                // if post contains image
                // MARK: - Caption + Timestamp -
                if vm.post.imageURL != nil {
                    VStack(spacing: 10) {
                        
                        (Text((authorUsername) + " ").fontWeight(.bold) + Text(vm.post.caption))
                            .expandableCaption()
                        
                        Text(vm.post.timestamp.timeAgo())
                            .foregroundStyle(.gray)
                            .font(.caption)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                }
                

            }
            .showCustomAlert(alert: $vm.alert)
        }
        
    }
}


#Preview {
    @Previewable @StateObject var successWithImage = PostRowViewModel(
        post: .generateMock(shortCaption: false),
        isLiked: true,
        isBookmarked: true,
        authorUsername: .loaded("LovesTomatoes"),
        authorImage: .loaded(ProfileImage.dummyUIImage),
        postImage: .loaded(UIImage(named: "dummy_post_image")!),
        isLoading: false,
        alert: nil
    )
    
    @Previewable @StateObject var successNoImage = PostRowViewModel(
        post: .generateMock(withImage: false, shortCaption: true),
        isLiked: true,
        isBookmarked: true,
        authorUsername: .loaded("LovesTomatoes"),
        authorImage: .loaded(ProfileImage.dummyUIImage),
        postImage: .loaded(nil),
        isLoading: false,
        alert: nil
    )
    
    @Previewable @StateObject var failure = PostRowViewModel(
        post: .generateMock(),
        isLiked: true,
        isBookmarked: true,
        authorUsername: .loaded("LovesTomatoes"),
        authorImage: .loaded(ProfileImage.dummyUIImage),
        postImage: .failed(URLError(.networkConnectionLost)),
        isLoading: false,
        alert: nil
    )
    
    @Previewable @StateObject var loading = PostRowViewModel(post: .generateMock(), isLoading: true)
    
    
    PostRow(
                        vm: successWithImage
//        vm: successNoImage
        //        vm: loading
        //                vm: failure
    )
}

