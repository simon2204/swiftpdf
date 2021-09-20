public struct PDFFont {
	let value: Font
	
	init(baseFont: Font.BaseFont) {
		self.value = Font(baseFont: baseFont, encoding: .macRomanEncoding)
	}
	
	public static let timesRoman 			= PDFFont(baseFont: .timesRoman)
	public static let helvetica 			= PDFFont(baseFont: .helvetica)
	public static let courier 				= PDFFont(baseFont: .courier)
	public static let symbol 				= PDFFont(baseFont: .symbol)
	public static let timesBold 			= PDFFont(baseFont: .timesBold)
	public static let helveticaBold 		= PDFFont(baseFont: .helveticaBold)
	public static let courierBold 			= PDFFont(baseFont: .courierBold)
	public static let zapfDingbats 			= PDFFont(baseFont: .zapfDingbats)
	public static let timesItalic			= PDFFont(baseFont: .timesItalic)
	public static let helveticaOblique 		= PDFFont(baseFont: .helveticaOblique)
	public static let courierOblique 		= PDFFont(baseFont: .courierOblique)
	public static let timesBoldItalic 		= PDFFont(baseFont: .timesBoldItalic)
	public static let helveticaBoldOblique  = PDFFont(baseFont: .helveticaOblique)
	public static let courierBoldOblique	= PDFFont(baseFont: .courierBoldOblique)
}
