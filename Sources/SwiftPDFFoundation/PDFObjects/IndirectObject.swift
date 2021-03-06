import Foundation

struct IndirectObject<Object> where Object: ExpressibleAsPDFData {
    /// Unique object identifier by which other objects can refer to.
    private var objectNumber: Int
    
    /// The object which gets to be labeled as an `IndirectObject`.
    private var object: Object
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    private(set) var reference: IndirectReference<Object>
    
    init(referencing object: Object, objectNumber: inout Int) {
        self.object = object
        self.objectNumber = objectNumber
        self.reference = IndirectReference(id: objectNumber)
		objectNumber += 1
    }
}

struct IndirectReference<Object> {
    fileprivate var id: Int
}

extension IndirectObject: ExpressibleAsPDFData where Object: ExpressibleAsPDFData {
    var pdfData: Data {
        "\(objectNumber) 0 obj"
        + Whitespace.crlf.rawValue
        + object.pdfData
        + Whitespace.crlf.rawValue
        + "endobj"
        + Whitespace.lineFeed.rawValue
    }
}

extension IndirectObject: ExpressibleAsPDFString where Object: ExpressibleAsPDFString {
    var pdfString: String {
        "\(objectNumber) 0 obj"
        + Whitespace.crlf
        + object.pdfString
        + Whitespace.crlf
        + "endobj"
        + Whitespace.lineFeed
    }
}

extension IndirectReference: ExpressibleAsPDFString {
    var pdfString: String {
        "\(id) 0 R"
    }
}
