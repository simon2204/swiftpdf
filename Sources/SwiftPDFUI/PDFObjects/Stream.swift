import Foundation

struct Stream {
	private var contents: [ExpressibleAsPDFData] = []
	
	private var contentData: Data {
		contents.lazy.map(\.pdfData).joined(separator: Whitespace.space.pdfData)
	}
    
	init() {}
	
	mutating func append(_ content: ExpressibleAsPDFData) {
		self.contents.append(content)
	}
}

extension Stream: ExpressibleAsPDFData {
	var pdfData: Data {
		let data = contentData
		let streamDict = StreamDictionary(length: data.count)
		
		return "\(streamDict)"
		+ Whitespace.lineFeed.rawValue
		+ "stream"
		+ Whitespace.lineFeed.rawValue
		+ data
		+ Whitespace.lineFeed.rawValue
		+ "endstream"
	}
}
