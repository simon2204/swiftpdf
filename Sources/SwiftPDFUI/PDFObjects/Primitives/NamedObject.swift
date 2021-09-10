import Foundation

struct NamedObject: PDFObject {
    let name: String

    var pdfData: Data {
        "/\(name)".data
    }
}

extension NamedObject: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.name = value
    }
}

extension NamedObject: Hashable { }
