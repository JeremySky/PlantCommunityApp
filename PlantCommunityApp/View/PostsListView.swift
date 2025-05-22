import SwiftUI

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








