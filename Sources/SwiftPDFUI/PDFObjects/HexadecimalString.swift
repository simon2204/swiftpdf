import Foundation

struct HexadecimalString {
    var value: String
	
	init(_ value: String) {
		self.value = value.hexEncodedString()
	}
    
    init(_ value: UUID) {
        self.value = value.uuidHex
    }
}

extension HexadecimalString: ExpressibleAsPDFString {
    var pdfString: String {
		"<\(value)>"
    }
}

extension HexadecimalString: ExpressibleByStringLiteral {
	init(stringLiteral value: String) {
		self.value = value
	}
}
