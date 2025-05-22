import Foundation
import SwiftUI

class ImageCacheManager {
    
    static let instance = ImageCacheManager()
    private init() {}
    
    private let cache: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 200 * 1024 * 1024
        return cache
    }()
    
    func set(key: String, value: UIImage) {
        cache.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
}
