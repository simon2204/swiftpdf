import Foundation

extension Array: ExpressibleAsPDFData where Element: ExpressibleAsPDFString {
    var pdfData: Data {
        Data(pdfString.utf8)
    }
}

extension Array: ExpressibleAsPDFString where Element: ExpressibleAsPDFString {
    var pdfString: String {
        "[" + lazy.map(\.pdfString).joined(separator: Whitespace.space.rawValue) + "]"
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
	
	func joined() -> Data {
		let dataCount = self.reduce(0) { $0 + $1.count }
		
		var result = Data(capacity: dataCount)
		
		for data in self {
			result.append(data)
		}
		
		return result
	}
}
