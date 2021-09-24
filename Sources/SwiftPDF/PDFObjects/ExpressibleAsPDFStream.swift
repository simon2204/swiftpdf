import Foundation

protocol ExpressibleAsPDFStream: ExpressibleAsPDFData {
	var pdfStream: [ExpressibleAsPDFData] { get }
}

extension ExpressibleAsPDFStream {
	var pdfData: Data {
		let data = pdfStream.joined(seperator: .space)
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
