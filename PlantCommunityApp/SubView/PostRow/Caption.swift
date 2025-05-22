import SwiftUI

extension PostRow {
    struct Caption: View {
        
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




