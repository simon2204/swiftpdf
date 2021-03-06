struct Null {}

extension Null: ExpressibleAsPDFString {
    var pdfString: String {
        "null"
    }
}

extension Null: ExpressibleByNilLiteral {
    init(nilLiteral: ()) {
        self.init()
    }
}
