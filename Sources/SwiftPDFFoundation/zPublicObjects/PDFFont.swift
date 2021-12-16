public struct PDFFont {
	let value: Font
	let resourceName: Name
	public let metrics: FontMetrics?
	
	init(baseFont: Font.BaseFont, resourceName: Name, metrics: FontMetrics? = nil) {
		self.value = Font(baseFont: baseFont, encoding: .macRomanEncoding)
		self.resourceName = resourceName
		self.metrics = metrics
	}
}

extension PDFFont: Hashable {}

extension PDFFont {
	public static let timesRoman = PDFFont(baseFont: .timesRoman, resourceName: "F0")
	public static let helvetica = PDFFont(baseFont: .helvetica, resourceName: "F1")
	public static let symbol = PDFFont(baseFont: .symbol, resourceName: "F3")
	public static let timesBold = PDFFont(baseFont: .timesBold, resourceName: "F4")
	public static let helveticaBold = PDFFont(baseFont: .helveticaBold, resourceName: "F5")
	public static let courierBold = PDFFont(baseFont: .courierBold, resourceName: "F6")
	public static let zapfDingbats = PDFFont(baseFont: .zapfDingbats, resourceName: "F7")
	public static let timesItalic = PDFFont(baseFont: .timesItalic, resourceName: "F8")
	public static let helveticaOblique = PDFFont(baseFont: .helveticaOblique, resourceName: "F9")
	public static let courierOblique = PDFFont(baseFont: .courierOblique, resourceName: "F10")
	public static let timesBoldItalic = PDFFont(baseFont: .timesBoldItalic, resourceName: "F11")
	public static let helveticaBoldOblique = PDFFont(baseFont: .helveticaOblique, resourceName: "F12")
	public static let courierBoldOblique = PDFFont(baseFont: .courierBoldOblique, resourceName: "F13")
	public static let courier: PDFFont = {
		let metrics = FontMetrics(
			unitsPerEm: 2048,
			xMin: -249,
			yMin: -1392,
			xMax: 1275,
			yMax: 2091,
			ascender: 1705,
			descender: -386,
			advanceWidthMax: 1229)
		return PDFFont(baseFont: .courier, resourceName: "F2", metrics: metrics)
	}()
}

extension PDFFont {
	public struct FontMetrics: Hashable {
		public let unitsPerEm: Int
		public let xMin: Int
		public let yMin: Int
		public let xMax: Int
		public let yMax: Int
		public let ascender: Int
		public let descender: Int
		public let advanceWidthMax: Int
	}
}

public extension PDFFont {
	func width(of char: Character, size: Double) -> Double {
		guard let metrics = self.metrics else { return Double.infinity }
		return size * Double(metrics.advanceWidthMax) / Double(metrics.unitsPerEm)
	}
}
