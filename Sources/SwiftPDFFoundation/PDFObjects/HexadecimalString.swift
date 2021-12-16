import Foundation

struct HexadecimalString {
    var value: String
	
	init<S: StringProtocol>(_ value: S) {
		let data = value.data(using: .macOSRoman, allowLossyConversion: true)
		self.value = data?.hexEncodedString() ?? ""
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
