struct Null: PDFObject {
    var pdfValue: String {
        "null"
    }
}

extension Null: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.init()
    }
}
