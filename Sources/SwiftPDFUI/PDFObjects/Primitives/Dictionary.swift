extension Dictionary: ExpressibleAsPDFObject where Key == Name, Value == ExpressibleAsPDFObject {
    var pdfRepresentation: String {
        "<<"
        + Whitespace.crlf
        + lazy.map { $0.key.name + " " + $0.value.pdfRepresentation }.joined(separator: Whitespace.crlf.rawValue)
        + Whitespace.crlf
        + ">>"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: [Name : ExpressibleAsPDFObject]) {
        appendInterpolation(value.pdfRepresentation)
    }
}
