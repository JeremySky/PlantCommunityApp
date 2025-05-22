import Foundation

enum HardinessZone: String, CaseIterable, Codable {
    case zone1a = "Zone 1A"
    case zone1b = "Zone 1B"
    case zone2a = "Zone 2A"
    case zone2b = "Zone 2B"
    case zone3a = "Zone 3A"
    case zone3b = "Zone 3B"
    case zone4a = "Zone 4A"
    case zone4b = "Zone 4B"
    case zone5a = "Zone 5A"
    case zone5b = "Zone 5B"
    case zone6a = "Zone 6A"
    case zone6b = "Zone 6B"
    case zone7a = "Zone 7A"
    case zone7b = "Zone 7B"
    case zone8a = "Zone 8A"
    case zone8b = "Zone 8B"
    case zone9a = "Zone 9A"
    case zone9b = "Zone 9B"
    case zone10a = "Zone 10A"
    case zone10b = "Zone 10B"
    case zone11a = "Zone 11A"
    case zone11b = "Zone 11B"
    case zone12a = "Zone 12A"
    case zone12b = "Zone 12B"
    case zone13a = "Zone 13A"
    case zone13b = "Zone 13B"
    
    var temperatureRange: String {
        switch self {
        case .zone1a: return "-60°F to -55°F"
        case .zone1b: return "-55°F to -50°F"
        case .zone2a: return "-50°F to -45°F"
        case .zone2b: return "-45°F to -40°F"
        case .zone3a: return "-40°F to -35°F"
        case .zone3b: return "-35°F to -30°F"
        case .zone4a: return "-30°F to -25°F"
        case .zone4b: return "-25°F to -20°F"
        case .zone5a: return "-20°F to -15°F"
        case .zone5b: return "-15°F to -10°F"
        case .zone6a: return "-10°F to -5°F"
        case .zone6b: return "-5°F to 0°F"
        case .zone7a: return "0°F to 5°F"
        case .zone7b: return "5°F to 10°F"
        case .zone8a: return "10°F to 15°F"
        case .zone8b: return "15°F to 20°F"
        case .zone9a: return "20°F to 25°F"
        case .zone9b: return "25°F to 30°F"
        case .zone10a: return "30°F to 35°F"
        case .zone10b: return "35°F to 40°F"
        case .zone11a: return "40°F to 45°F"
        case .zone11b: return "45°F to 50°F"
        case .zone12a: return "50°F to 55°F"
        case .zone12b: return "55°F to 60°F"
        case .zone13a: return "60°F to 65°F"
        case .zone13b: return "65°F and above"
        }
    }
}



struct Post: Identifiable, Codable {
    var id: String?
    let authorId: String
    let hardinessZone: HardinessZone?
    let imageURL: String?
    var caption: String
    let timestamp: Date
    var likesCount: Int
    var isLiked: Bool
    var tags: [String]
    var comments: [String]?
    var commentCount: Int
    var isBookmarked: Bool
    
    init(
        id: String?,
        authorId: String,
        hardinessZone: HardinessZone?,
        imageURL: String?,
        caption: String,
        timestamp: Date,
        likesCount: Int,
        isLiked: Bool,
        tags: [String],
        comments: [String]?,
        commentCount: Int,
        isBookmarked: Bool
    ) {
        self.id = id
        self.authorId = authorId
        self.hardinessZone = hardinessZone
        self.imageURL = imageURL
        self.caption = caption
        self.timestamp = timestamp
        self.likesCount = likesCount
        self.isLiked = isLiked
        self.tags = tags
        self.comments = comments
        self.commentCount = commentCount
        self.isBookmarked = isBookmarked
    }
}

#if DEBUG
extension Post {
    static let samplePosts: [Post] = [
        Post(
            id: "abc123",
            authorId: "user001",
            hardinessZone: .zone8b,
            imageURL: "https://picsum.photos/1080/1350",
            caption: "Loving the spring growth in zone 8b 🌱",
            timestamp: Date(),
            likesCount: 42,
            isLiked: false,
            tags: ["spring", "tomatoes", "zone8b"],
            comments: ["Looks great!", "What variety is that?"],
            commentCount: 2,
            isBookmarked: true
        ),
        Post(
            id: "def456",
            authorId: "user002",
            hardinessZone: .zone9a,
            imageURL: "https://picsum.photos/1080/580",
            caption: "Trying raised beds this season. Wish me luck!",
            timestamp: Date().addingTimeInterval(-86400 * 7),
            likesCount: 12,
            isLiked: false,
            tags: ["raisedbeds", "gardening", "zone9a"],
            comments: ["Good luck!", "What soil mix did you use?"],
            commentCount: 2,
            isBookmarked: false
        )
    ]
    
    static func generateMock(id: String? = nil) -> Post {
        return Post(
            id: id ?? UUID().uuidString,
            authorId: UUID().uuidString,
            hardinessZone: HardinessZone.allCases.randomElement(),
            imageURL: "https://picsum.photos/1080/1350",
            caption: "Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿Just planted something new! I hope to share more soon... 🌿",
            timestamp: Date().addingTimeInterval(TimeInterval(-Int.random(in: 0...(86400 * 365)))),
            likesCount: Int.random(in: 0...100),
            isLiked: Bool.random(),
            tags: ["plants", "garden"],
            comments: ["Nice!", "Looking forward to updates."],
            commentCount: 2,
            isBookmarked: false
        )
    }
}
#endif
