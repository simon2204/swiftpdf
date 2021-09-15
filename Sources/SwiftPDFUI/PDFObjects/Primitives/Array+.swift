import Foundation

extension Array where Element == Data {
    func joined(separator: Data = .init()) -> Data {
        let dataCount = self.reduce(0) { $0 + $1.count }
        let separatorDataCount = count * separator.count
        let capacity = dataCount + separatorDataCount
        
        var result = Data(capacity: capacity)
        
        if separator.isEmpty {
            for data in self {
                result.append(data)
            }
            return result
        }

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

extension Array: PDFObject where Element: PDFObject {
    var pdfData: Data {
        "[" + lazy.map(\.pdfData).joined(separator: Whitespace.space) + "]"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation<Element: PDFObject>(_ value: Array<Element>) {
        let array = String(data: value.pdfData, encoding: .utf8)!
        appendInterpolation(array)
    }
}
