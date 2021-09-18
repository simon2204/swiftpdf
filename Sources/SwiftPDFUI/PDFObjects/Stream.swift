import Foundation

struct Stream: ExpressibleAsPDFData {
    var data: Data
    
    private var dict: StreamDictionary {
        StreamDictionary(length: data.count)
    }
    
	var pdfData: Data {
        "\(dict)"
        + Whitespace.lineFeed.rawValue
        + "stream"
        + Whitespace.lineFeed.rawValue
		+ data
        + Whitespace.lineFeed.rawValue
        + "endstream"
	}
}

extension Stream {
    struct StreamDictionary: ExpressibleAsPDFDictionary {
        var length: Int
        
        var pdfDictionary: [Name : ExpressibleAsPDFString] {
            ["length" : length]
        }
    }
}
