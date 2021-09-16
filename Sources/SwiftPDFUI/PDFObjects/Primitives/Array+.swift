extension Array: ExpressibleAsPDFObject where Element: ExpressibleAsPDFObject {
    var pdfRepresentation: String {
        "[" + lazy.map(\.pdfRepresentation).joined(separator: Whitespace.space.rawValue) + "]"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation<Element: ExpressibleAsPDFObject>(_ value: Array<Element>) {
        appendInterpolation(value.pdfRepresentation)
    }
}
