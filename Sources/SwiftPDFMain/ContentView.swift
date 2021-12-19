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

struct Seperator: View {

    var title: String?

    var body: some View {
        HStack(spacing: 0) {
            
            Color.black.frame(height: 1)

            if let title = title {
                Text(title).padding(.horizontal)
            }

            Color.black.frame(height: 1)
        }
    }
}
