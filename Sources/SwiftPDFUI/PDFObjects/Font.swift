struct Font {
	private static let type: Name = "font"
	
	private static let subtype: Name = "type1"
	
	var baseFont: BaseFont
	
	var encoding: Encoding?
}

extension Font {
	enum BaseFont: Name {
		case timesRoman = "Times-Roman"
		case helvetica = "Helvetica"
		case Courier = "Courier"
		case symbol = "Symbol"
		case timesBold = "Times-Bold"
		case helveticaBold = "Helvetica-Bold"
		case courierBold = "Courier-Bold"
		case zapfDingbats = "ZapfDingbats"
		case timesItalic = "Times-Italic"
		case helveticaOblique = "Helvetica-Oblique"
		case courierOblique = "Courier-Oblique"
		case timesBoldItalic = "Times-BoldItalic"
		case helveticaBoldOblique = "Helvetica-BoldOblique"
		case courierBoldOblique = "Courier-BoldOblique"
	}
}

extension Font {
	enum Encoding: Name {
		case macRomanEncoding
		case macExpertEncoding
		case winAnsiEncoding
	}
}

extension Font: ExpressibleAsPDFDictionary {
	var pdfDictionary: [Name : ExpressibleAsPDFString] {
		["type" : Self.type,
		 "subtype" : Self.subtype,
		 "baseFont" : baseFont,
		 "encoding" : encoding]
	}
}

extension Font.BaseFont: ExpressibleAsPDFString {
	var pdfString: String {
		self.rawValue.pdfString
	}
}

extension Font.Encoding: ExpressibleAsPDFString {
	var pdfString: String {
		self.rawValue.pdfString
	}
}
