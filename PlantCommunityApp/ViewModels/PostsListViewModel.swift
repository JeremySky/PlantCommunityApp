import Foundation

class PostsListViewModel: ObservableObject {
    @Published var posts: Loadable<[Post]>
    
    init(posts: Loadable<[Post]> = .loading) {
        self.posts = posts
    }
    
    func createPostRowViewModel(for post: Post) -> PostRowViewModel {
        #if DEBUG
        return PostRowViewModel(
            post: post,
            authorUsername: .loaded("UserNo\(Int.random(in: 1...100))"),
            authorImage: .loaded(ProfileImage.dummyUIImage),
            postImage: .loaded(Post.dummyUIImage),
            isLoading: false
        )
        #else
        
        let vm = PostRowViewModel(post: post)
        return vm
        
        #endif
    }
}
