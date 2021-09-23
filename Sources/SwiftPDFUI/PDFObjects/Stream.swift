import Foundation

struct Stream {
	var contents: [ExpressibleAsPDFData] = []
	
	mutating func append(_ content: ExpressibleAsPDFData) {
		self.contents.append(content)
	}
}

extension Stream: ExpressibleAsPDFStream {
	var pdfStream: [ExpressibleAsPDFData] {
		contents
	}
}
