import Foundation
import SwiftUI

class ImageFileManager {
    
    static let instance = ImageFileManager()
    let folderName = "downloaded_images"
    
    private init() {}
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
                log("Created folder: \(folderName)", level: .info)
            } catch let error {
                log("Error creating folder: \(error)", level: .error)
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        let imagePath = folder.appendingPathComponent(key + ".png")
        return imagePath
    }
    
    func set(key: String, value: UIImage) {
        guard
            let data = value.pngData(),
            let url = getImagePath(key: key)
                else { return }
        
        do {
            try data.write(to: url)
            log("Saved image to file manager: \(key)", level: .info)
        } catch let error {
            log("Error saving image to file manager: \(error)", level: .error)
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path)
                else { return nil }
        
        return UIImage(contentsOfFile: url.path)
    }
}
