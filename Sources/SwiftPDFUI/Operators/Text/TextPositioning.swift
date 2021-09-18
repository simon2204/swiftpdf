enum TextPositioning {
    /// Move to the start of the next line.
    ///
    /// - Parameters:
    ///   - dx: Offset from the start of the current line by `dx`.
    ///   - dy: Offset from the start of the current line by `dy`.
    case move(dx: Double, dy: Double)
    
    /// Move to the start of the next line.
    ///
    /// This operator has the same effect as the code:
    /// ```swift
    /// let leading = 12.0 // Denotes the current leading parameter in the text state.
    /// TextPositioning.move(dx: 0, dy: -leading)
    /// ```
    case newLine
}

extension TextPositioning: ExpressibleAsPDFString {
    var pdfString: String {
        switch self {
        case let .move(dx, dy):
            return "\(dx) \(dy) Td"
            
        case .newLine:
            return "T*"
        }
    }
}
