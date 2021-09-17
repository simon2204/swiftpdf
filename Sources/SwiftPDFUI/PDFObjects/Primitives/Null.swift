struct Null: ExpressibleAsPDFString {
    var pdfString: String {
        "null"
    }
}

extension Null: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.init()
    }
}

extension String.StringInterpolation {
	/// Interpolates the given value’s textual representation into the string literal being created.
	mutating func appendInterpolation(_ value: Null) {
		appendInterpolation(value.pdfString)
	}
}
