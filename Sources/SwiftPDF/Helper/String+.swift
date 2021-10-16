import Foundation

extension String {
    static func += (lhs: inout String, rhs: Whitespace) {
        lhs += rhs.rawValue
    }
    
    static func + (lhs: String, rhs: Whitespace) -> String {
        lhs + rhs.rawValue
    }
    
    static func + (lhs: Whitespace, rhs: String) -> String {
        lhs.rawValue + rhs
    }
}

extension String {
	func hexEncodedString() -> String {
		Data(utf8).map { String(format: "%02hhX", $0) }.joined()
	}
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: ExpressibleAsPDFString) {
        appendInterpolation(value.pdfString)
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}

public extension String {
	func removeTrailingWhitespaces() -> String {
		guard !isEmpty else { return self }
		
		let reversedString = reversed()
		
		var lastIndexWithoutWhitespace = endIndex
		
		for char in reversedString {
			if char == " " {
				lastIndexWithoutWhitespace = index(before: lastIndexWithoutWhitespace)
			} else {
				break
			}
		}
		
		return String(self[startIndex..<lastIndexWithoutWhitespace])
	}
}
