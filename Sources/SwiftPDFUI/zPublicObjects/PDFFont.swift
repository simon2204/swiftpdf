public struct PDFFont {
	let value: Font
	let resourceName: Name
	
	init(baseFont: Font.BaseFont, resourceName: Name) {
		self.value = Font(baseFont: baseFont, encoding: .macRomanEncoding)
		self.resourceName = resourceName
	}
	
	public static let timesRoman 			= PDFFont(baseFont: .timesRoman, resourceName: "F0")
	public static let helvetica 			= PDFFont(baseFont: .helvetica, resourceName: "F1")
	public static let courier 				= PDFFont(baseFont: .courier, resourceName: "F2")
	public static let symbol 				= PDFFont(baseFont: .symbol, resourceName: "F3")
	public static let timesBold 			= PDFFont(baseFont: .timesBold, resourceName: "F4")
	public static let helveticaBold 		= PDFFont(baseFont: .helveticaBold, resourceName: "F5")
	public static let courierBold 			= PDFFont(baseFont: .courierBold, resourceName: "F6")
	public static let zapfDingbats 			= PDFFont(baseFont: .zapfDingbats, resourceName: "F7")
	public static let timesItalic			= PDFFont(baseFont: .timesItalic, resourceName: "F8")
	public static let helveticaOblique 		= PDFFont(baseFont: .helveticaOblique, resourceName: "F9")
	public static let courierOblique 		= PDFFont(baseFont: .courierOblique, resourceName: "F10")
	public static let timesBoldItalic 		= PDFFont(baseFont: .timesBoldItalic, resourceName: "F11")
	public static let helveticaBoldOblique  = PDFFont(baseFont: .helveticaOblique, resourceName: "F12")
	public static let courierBoldOblique	= PDFFont(baseFont: .courierBoldOblique, resourceName: "F13")
}

extension PDFFont: Hashable {}
