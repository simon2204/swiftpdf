struct StreamDictionary: ExpressibleAsPDFDictionary {
	var length: Int
	
	var pdfDictionary: [Name : ExpressibleAsPDFString] {
		["length" : length]
	}
}
