import SwiftUI

@main
struct PlantCommunityApp: App {
    var body: some Scene {
        WindowGroup {
            if true {
                HomeView()
            } else {
                AuthView()
            }
        }
    }
}
