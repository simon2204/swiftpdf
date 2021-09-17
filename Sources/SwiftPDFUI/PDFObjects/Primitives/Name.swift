struct Name: ExpressibleAsPDFString {
    let name: String

    init(_ name: String) {
        self.name = name
    }
    
    var pdfString: String {
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
	/// Interpolates the given value’s textual representation into the string literal being created.
    mutating func appendInterpolation(_ value: Name) {
        appendInterpolation(value.pdfString)
    }
}
