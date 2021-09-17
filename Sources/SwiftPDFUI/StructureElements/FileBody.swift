import Foundation

struct FileBody: ExpressibleAsPDFString {
	
	mutating func appendObject<Object: ExpressibleAsPDFString>(_ indirectObject: IndirectObject<Object>) {
		
	}
	
	var pdfString: String {
		""
	}
}
