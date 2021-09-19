import Foundation

final class IndirectObject<Object> {
    /// Unique object identifier by which other objects can refer to.
    var objectNumber = 0
    
    /// The object which gets to be labeled as an `IndirectObject`.
    var object: Object
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    var reference: IndirectReference<Object> {
        IndirectReference(self)
    }
    
    init(referencing object: Object) {
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
