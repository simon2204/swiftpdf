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
        HStack {
            Color.green
                .padding(20)
            Spacer(minLength: 80)
            Color.red
            Spacer()
            Color.blue
                .frame(width: 100)
            Color.purple
        }
        .frame(width: 400)
    }
}
