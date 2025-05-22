import SwiftUI

struct ProfileImage: View {
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


extension ProfileImage {
    static let defaultFileName = "default_avatar"
    static let defaultUIImage: UIImage = UIImage(named: defaultFileName)!
    
    #if DEBUG
    static let dummyFileName: String = "dummy_profile_image"
    static let dummyUIImage: UIImage = UIImage(named: dummyFileName)!
    #endif
}

extension ProfileImage {
    static func defaultAvatar(for type: ProfileImageType) -> ProfileImage {
        ProfileImage(ProfileImage.defaultUIImage, for: type)
    }
}

#Preview {
    ProfileImage.defaultAvatar(for: .post)
}
