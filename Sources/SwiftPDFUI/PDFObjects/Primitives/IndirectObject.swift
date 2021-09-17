struct IndirectObject<Object>: ExpressibleAsPDFString where Object: ExpressibleAsPDFString {
    /// Unique object identifier by which other objects can refer to.
    private let objectNumber: Int
    
    /// The object which gets to be labelled as an `IndirectObject`.
    private let object: ExpressibleAsPDFString
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    var reference: IndirectReference<Object> {
        IndirectReference(id: objectNumber)
    }
    
    init(referencing object: Object, number: Int) {
        self.objectNumber = number
        self.object = object
    }
    
    var pdfString: String {
        "\(objectNumber) 0 obj"
        + Whitespace.crlf
        + object.pdfString
        + Whitespace.crlf
        + "endobj"
    }
}
