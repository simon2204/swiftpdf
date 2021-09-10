import Foundation

struct Null: PDFObject {
    var pdfData: Data {
        "null"
    }
}

extension Null: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.init()
    }
}
