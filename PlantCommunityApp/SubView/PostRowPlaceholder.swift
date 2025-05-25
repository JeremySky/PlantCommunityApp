import SwiftUI

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


