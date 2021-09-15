extension Array: PDFObject where Element: PDFObject {
    var pdfValue: String {
        "[" + lazy.map(\.pdfValue).joined(separator: Whitespace.space.rawValue) + "]"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation<Element: PDFObject>(_ value: Array<Element>) {
        appendInterpolation(value.pdfValue)
    }
}
