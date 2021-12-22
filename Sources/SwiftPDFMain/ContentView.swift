import SwiftPDF
import Foundation

struct DarkDocumentationBackgroundModifier: ViewModifier {
    let darkBackgroundColor = Color(red: 0.12, green: 0.12, blue: 0.12)
    func body(content: Content) -> some View {
        content.background {
            darkBackgroundColor
        }
    }
}

extension View {
    func darkDocumentationBackground() -> some View {
        self.modifier(DarkDocumentationBackgroundModifier())
    }
}

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
    }
}
