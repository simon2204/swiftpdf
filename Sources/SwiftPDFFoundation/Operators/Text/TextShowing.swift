enum TextShowing {
    /// Show a text string.
    case show(HexadecimalString)
    
    /// Move to the next line and show a text string.
    case nextLine(HexadecimalString)
    
    /// Move to the next line, show a text string and set word- and character spacing.
    ///
    /// - Parameters:
    ///   - word: Word spacing in unscaled text space units.
    ///   - character: Character spacing in unscaled text space units.
    ///   - text: Text to display.
    case nextLineWithSpacing(word: Double, character: Double, text: HexadecimalString)
}

extension TextShowing: ExpressibleAsPDFString {
    var pdfString: String {
        switch self {
        case let .show(text):
            return "\(text) Tj"
            
        case let .nextLine(text):
            return "\(text) '"
        
        case let .nextLineWithSpacing(wordSpacing, characterSpacing, text):
            return "\(wordSpacing) \(characterSpacing) \(text) \""
        }
    }
}
