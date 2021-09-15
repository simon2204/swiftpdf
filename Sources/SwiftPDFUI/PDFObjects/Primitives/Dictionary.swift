extension Dictionary: PDFObject where Key == Name, Value == PDFObject {
    var pdfValue: String {
        "<<"
        + Whitespace.crlf
        + lazy.map { $0.key.name + " " + $0.value.pdfValue }.joined(separator: Whitespace.crlf.rawValue)
        + Whitespace.crlf
        + ">>"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: [Name : PDFObject]) {
        appendInterpolation(value.pdfValue)
    }
}
