import Foundation

extension Array: ExpressibleAsPDFData where Element: ExpressibleAsPDFString {
    var pdfData: Data {
        Data(pdfString.utf8)
    }
}

extension Array: ExpressibleAsPDFString where Element: ExpressibleAsPDFString {
    var pdfString: String {
        "[" + lazy.map(\.pdfString).joined(separator: Whitespace.space.rawValue) + "]"
    }
}

extension String.StringInterpolation {
    /// Interpolates the given value’s textual representation into the string literal being created.
    mutating func appendInterpolation<Element: ExpressibleAsPDFString>(_ value: Array<Element>) {
        appendInterpolation(value.pdfString)
    }
}
