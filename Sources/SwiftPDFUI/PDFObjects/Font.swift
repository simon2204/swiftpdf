struct Font: ExpressibleAsPDFDictionary {
	private static let type: Name = "Font"
	
	var subtype: Name
	
	var baseFont: Name
	
	var firstChar: Int
	
	var lastChar: Int
	
	var widths: IndirectReference<[Double]>
	
	var fontDescriptor: Null
	
	var encoding: Encoding
	
	var toUnicode: IndirectReference<Stream>?
	
	var dictionary: [Name : ExpressibleAsPDFString] {
		["type" : Self.type,
		 "subtype" : subtype,
		 "firstChar" : firstChar,
		 "lastChar" : lastChar,
		 "widths" : widths,
		 "fontDescriptor" : fontDescriptor,
		 "encoding" : encoding.rawValue,
		 "toUnicode" : toUnicode]
	}
}

enum Encoding: Name {
	case macRomanEncoding
	case macExpertEncoding
	case winAnsiEncoding
}
