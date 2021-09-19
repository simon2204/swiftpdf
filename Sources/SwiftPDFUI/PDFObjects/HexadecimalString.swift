struct HexadecimalString {
    var value: String
	
	init(_ value: String) {
		self.value = value
	}
}

extension HexadecimalString: ExpressibleAsPDFString {
    var pdfString: String {
		"<\(value.hexEncodedString())>"
    }
}

extension HexadecimalString: ExpressibleByStringLiteral {
	init(stringLiteral value: String) {
		self.value = value
	}
}
