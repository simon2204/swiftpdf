struct Name: PDFObject {
    let name: String

    init(_ name: String) {
        self.name = name
    }
    
    var pdfValue: String {
        "/\(name.capitalized)"
    }
}

extension Name: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.name = value
    }
}

extension Name: Hashable { }

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Name) {
        appendInterpolation(value.pdfValue)
    }
}
