public struct PDFText {
	var text: HexadecimalString
	var font: PDFFont
	
	public var fontSize: Double
	public var color: PDFColor = .black
	public var position: PDFPoint = .zero
	
	public init<S: StringProtocol>(_ content: S, font: PDFFont, size: Double = 11) {
		self.text = HexadecimalString(content)
		self.font = font
		self.fontSize = size
	}
}
