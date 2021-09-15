import Foundation

struct NamedObject: PDFObject {
    let name: String

    var pdfValue: Data {
        "/\(name.capitalized)".data
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
        let namedObject = String(data: value.pdfValue, encoding: .utf8)!
        appendInterpolation(namedObject)
    }
}
