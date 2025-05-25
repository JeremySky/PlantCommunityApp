import SwiftUI

struct ExpandableCaptionModifier: ViewModifier {
    
    @State private var isExpanded: Bool = false
    @State private var canBeExpanded: Bool = false

    func body(content: Content) -> some View {
        HStack(spacing: 0) {
            content
                .lineLimit(isExpanded ? nil : 1)
                .background(
                    ViewThatFits(in: .vertical) {
                        content.hidden()
                        Color.clear.onAppear {
                            canBeExpanded = true
                        }
                    }
                )

            if !isExpanded && canBeExpanded {
                Button(" more") {
                    isExpanded = true
                }
                .fontWeight(.semibold)
                .foregroundStyle(.gray.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
extension Text {
    func expandableCaption() -> some View {
        modifier(ExpandableCaptionModifier())
    }
}
