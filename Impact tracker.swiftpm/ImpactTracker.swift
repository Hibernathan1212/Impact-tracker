import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            #if os(iOS)
            ContentView()
            #else
            MacContentView()
            #endif
        }
    }
}
