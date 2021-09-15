import Foundation

struct Null: PDFObject {
    var pdfValue: Data {
        "null"
    }
}

extension Null: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.init()
    }
}
