struct Null: ExpressibleAsPDFObject {
    var pdfRepresentation: String {
        "null"
    }
}

extension Null: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.init()
    }
}
