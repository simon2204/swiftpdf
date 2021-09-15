import Foundation

struct IndirectObject<Object>: PDFObject where Object: PDFObject {
    /// Unique object identifier by which other objects can refer to.
    private let objectNumber: Int
    
    /// The object which gets to be labelled as an `IndirectObject`.
    private let object: PDFObject
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    var reference: Reference<Object> {
        Reference(id: objectNumber)
    }
    
    init(referencing object: Object, number: Int) {
        self.objectNumber = number
        self.object = object
    }
    
    var pdfValue: Data {
        "\(objectNumber) 0 obj"
        + Whitespace.crlf
        + object.pdfValue
        + Whitespace.crlf
        + "endobj"
    }
}

struct Reference<Object>: PDFObject where Object: PDFObject {
    fileprivate let id: Int
    
    var pdfValue: Data {
        "\(id) 0 R"
    }
}
