import Foundation
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
