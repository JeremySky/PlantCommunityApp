import SwiftUI

struct PostsListView: View {
    @StateObject var vm: PostsListViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                switch vm.posts {
                    
                    
                case .loading:
                    PostRow.placeholder
                    PostRow.placeholder
                    
                    
                case .loaded(let posts):
                    ForEach(posts) { post in
                        PostRow(
                            vm: vm.createPostRowViewModel(for: post)
                        )
                    }
                    
                    
                case .failed(_):
                    VStack(spacing: 14) {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundStyle(.orange)
                        Text("Error Loading Posts")
                            .foregroundStyle(.primary.opacity(0.6))
                    }
                    .frame(height: 700)
                }
                
                
            }
        }
    }
}


#Preview {
    @Previewable @StateObject var success = PostsListViewModel(posts: .loaded([.generateMock(), .generateMock(), .generateMock(), .generateMock(), .generateMock(), .generateMock()]))
    @Previewable @StateObject var loading = PostsListViewModel(posts: .loading)
    @Previewable @StateObject var failed = PostsListViewModel(posts: .failed(URLError(.networkConnectionLost)))
    
    PostsListView(
        //                vm: success
        vm: loading
        //                vm: failed
    )
}








