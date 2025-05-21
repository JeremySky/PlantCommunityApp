//
//  ProfileImage.swift
//  PlantCommunityApp
//
//  Created by Jeremy Manlangit on 5/21/25.
//

import SwiftUI

struct ProfileImage: View {
    let image: UIImage
    let type: ProfileImageType
    
    init(_ image: UIImage, type: ProfileImageType) {
        self.image = image
        self.type = type
    }
    
    var body: some View {
        
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 44, height: 44)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.gray, lineWidth: 2))
        
    }
}

extension ProfileImage {
    public enum ProfileImageType {
        case post
    }
}

#Preview {
    ProfileImage(UIImage(named: "default_avatar")!, type: .post)
}
