struct IndirectObject<Object>: ExpressibleAsPDFObject where Object: ExpressibleAsPDFObject {
    /// Unique object identifier by which other objects can refer to.
    private let objectNumber: Int
    
    /// The object which gets to be labelled as an `IndirectObject`.
    private let object: ExpressibleAsPDFObject
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    var reference: Reference<Object> {
        Reference(id: objectNumber)
    }
    
    init(referencing object: Object, number: Int) {
        self.objectNumber = number
        self.object = object
    }
    
    var pdfRepresentation: String {
        "\(objectNumber) 0 obj"
        + Whitespace.crlf
        + object.pdfRepresentation
        + Whitespace.crlf
        + "endobj"
    }
}

struct Reference<Object>: ExpressibleAsPDFObject where Object: ExpressibleAsPDFObject {
    fileprivate let id: Int
    
    var pdfRepresentation: String {
        "\(id) 0 R"
    }
}
