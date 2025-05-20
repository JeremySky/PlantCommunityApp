//
//  PostRowView.swift
//  PlantCommunityApp
//
//  Created by Jeremy Manlangit on 5/20/25.
//

import SwiftUI

struct PostRow: View {
    @State var post: Post
    
    init(_ post: Post) { self.post = post }
    
    var body: some View {
        VStack(spacing: 14) {
            
            
            // MARK: -- Header
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
            
            
            // MARK: -- Content Image
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
            
            
            // MARK: -- Actions
            HStack(spacing: 14) {
                HStack {
                    
                    // Like Button
                    Button {
                        post.isLiked.toggle()
                    } label: {
                        Image(systemName: post.isLiked ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundStyle(post.isLiked ? .red.opacity(0.8) : .primary)
                    }
                    
                    // Likes Count: On tap, display a list of users who liked the post
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
            
            
            // MARK: -- Caption
            VStack(spacing: 10) {
                
                // Username + Caption
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
                
                // Timestamp
                Text(post.timestamp.timeAgo())
                    .foregroundStyle(.gray)
                    .font(.caption)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)
        }
    }
}


#Preview {
    PostRow(Post.generateMock())
}
