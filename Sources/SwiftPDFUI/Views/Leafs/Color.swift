import SwiftPDF

public struct Color: View {
	let pdfColor: PDFColor
	
	public init(red: Double, green: Double, blue: Double) {
		pdfColor = PDFColor(red: red, green: green, blue: blue)
	}
}

public extension Color {
	static let black = Color(red: 0, green: 0, blue: 0)
	static let blue = Color(red: 0.04, green: 0.52, blue: 1)
	static let brown = Color(red: 0.67, green: 0.56, blue: 0.41)
	static let cyan = Color(red: 0.35, green: 0.78, blue: 0.96)
	static let gray = Color(red: 0.6, green: 0.6, blue: 0.62)
	static let green = Color(red: 0.2, green: 0.84, blue: 0.29)
	static let indigo = Color(red: 0.37, green: 0.36, blue: 0.9)
	static let mint = Color(red: 0.39, green: 0.9, blue: 0.89)
	static let orange = Color(red: 1, green: 0.62, blue: 0.04)
	static let pink = Color(red: 1, green: 0.22, blue: 0.37)
	static let purple = Color(red: 0.75, green: 0.35, blue: 0.95)
	static let red = Color(red: 1, green: 0.27, blue: 0.23)
	static let teal = Color(red: 0.42, green: 0.77, blue: 0.86)
	static let white = Color(red: 1, green: 1, blue: 1)
	static let yellow = Color(red: 1, green: 0.84, blue: 0.2)
}

extension Color: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let drawable = ColorDrawable(color: pdfColor)
		parent.add(child: drawable)
	}
}
