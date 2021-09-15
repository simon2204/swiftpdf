struct NamedObject: PDFObject {
    let name: String

    var pdfValue: String {
        "/\(name.capitalized)"
    }
}

extension NamedObject: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.name = value
    }
}

extension NamedObject: Hashable { }

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: NamedObject) {
        appendInterpolation(value.pdfValue)
    }
}
