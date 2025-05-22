import SwiftUI

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
            authorImage: .loaded(ProfileImageView.dummyAvatarUIImage),
            postImage: .loaded(UIImage(named: "dummy_post_image")!),
            isLoading: false
        )
        #else
        
        let vm = PostRowViewModel(post: post)
        return vm
        
        #endif
    }
}

struct PostsListView: View {
    @StateObject var vm: PostsListViewModel
    
    var body: some View {
        switch vm.posts {
        case .loading:
            ScrollView {
                VStack(spacing: 60) {
                    PostRow.placeholder
                    PostRow.placeholder
                }
            }
        case .loaded(let posts):
            ScrollView {
                VStack(spacing: 30) {
                    ForEach(posts) { post in
                        PostRow(
                            vm: vm.createPostRowViewModel(for: post)
                        )
                    }
                }
            }
        case .failed(_):
            VStack {
                Image(systemName: "exclamationmark.triangle")
                Text("Error Loading Posts")
            }
        }
    }
}


#Preview {
    @Previewable @StateObject var success = PostsListViewModel(posts: .loaded([.generateMock(), .generateMock(), .generateMock(), .generateMock(), .generateMock(), .generateMock()]))
    @Previewable @StateObject var loading = PostsListViewModel(posts: .loading)
    @Previewable @StateObject var failed = PostsListViewModel(posts: .failed(URLError(.networkConnectionLost)))
    
    PostsListView(
        vm: success
//        vm: loading
//        vm: failed
    )
}








