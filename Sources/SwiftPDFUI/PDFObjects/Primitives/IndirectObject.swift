import Foundation

struct IndirectObject<Object> {
    /// Unique object identifier by which other objects can refer to.
    private let objectNumber: Int
    
    /// The object which gets to be labeled as an `IndirectObject`.
    private let object: Object
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    var reference: IndirectReference<Object> {
        IndirectReference(id: objectNumber)
    }
    
    init(referencing object: Object, number: Int) {
        self.objectNumber = number
        self.object = object
    }
}

extension IndirectObject: ExpressibleAsPDFData where Object: ExpressibleAsPDFData {
	var pdfData: Data {
		"\(objectNumber) 0 obj"
		+ Whitespace.crlf.rawValue
		+ object.pdfData
		+ Whitespace.crlf.rawValue
		+ "endobj"
	}
}

extension IndirectObject: ExpressibleAsPDFString where Object: ExpressibleAsPDFString {
	var pdfString: String {
		"\(objectNumber) 0 obj"
		+ Whitespace.crlf
		+ object.pdfString
		+ Whitespace.crlf
		+ "endobj"
	}
}
