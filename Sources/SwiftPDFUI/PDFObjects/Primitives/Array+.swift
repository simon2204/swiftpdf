import Foundation

extension Array: ExpressibleAsPDFData where Element: ExpressibleAsPDFData {
    var pdfData: Data {
		"[" + lazy.map(\.pdfData).joined(seperator: .space) + "]"
    }
}

extension Array: ExpressibleAsPDFString where Element: ExpressibleAsPDFString {
    var pdfString: String {
		"[" + lazy.map(\.pdfString).joined(seperator: .space) + "]"
    }
}

extension Array where Element == Data {
	func joined(separator: Data) -> Data {
		guard !separator.isEmpty else {
			return joined()
		}
		
		let dataCount = self.reduce(0) { $0 + $1.count }
		let separatorDataCount = count * separator.count
		let capacity = dataCount + separatorDataCount
		
		var result = Data(capacity: capacity)
		
		var iterator = makeIterator()
		
		if let first = iterator.next() {
			result.append(first)
			while let next = iterator.next() {
				result.append(separator)
				result.append(next)
			}
		}
		
		return result
	}
}

extension Array where Element == Data {
	func joined() -> Data {
		let dataCount = self.reduce(0) { $0 + $1.count }
		
		var result = Data(capacity: dataCount)
		
		for data in self {
			result.append(data)
		}
		
		return result
	}
}

extension Array where Element == Data {
	func joined(seperator: Whitespace) -> Data {
		joined(separator: Data(seperator.rawValue.utf8))
	}
}

extension Array where Element == String {
	func joined(seperator: Whitespace) -> String {
		joined(separator: seperator.rawValue)
	}
}
