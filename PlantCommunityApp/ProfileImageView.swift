import SwiftUI

struct ProfileImageView: View {
    let image: UIImage
    let type: ProfileImageType
    
    init(_ image: UIImage, for type: ProfileImageType) {
        self.image = image
        self.type = type
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: type.size, height: type.size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
    }
}

enum ProfileImageType {
    case post
    
    var size: CGFloat {
        switch self {
        case .post:
            return 44
        }
    }
}


extension ProfileImageView {
    static let defaultAvatarFileName = "default_avatar"
    static let defaultAvatarUIImage: UIImage = UIImage(named: defaultAvatarFileName)!
    
    #if DEBUG
    static let dummyAvatarFileName: String = "dummy_profile_image"
    static let dummyAvatarUIImage: UIImage = UIImage(named: dummyAvatarFileName)!
    #endif
}

extension ProfileImageView {
    static func defaultAvatar(for type: ProfileImageType) -> ProfileImageView {
        ProfileImageView(ProfileImageView.defaultAvatarUIImage, for: type)
    }
}

#Preview {
    ProfileImageView.defaultAvatar(for: .post)
}
