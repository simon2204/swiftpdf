import SwiftPDF

public struct Text: View {
	
	var content: String
	
	var modifiers: [Modifier] = []
	
	init(_ content: String, modifiers: [Modifier]) {
		self.content = content
		self.modifiers = modifiers
	}
	
	public init<S>(_ content: S) where S: StringProtocol {
		self.content = String(content)
	}
}

extension Text {
	enum Modifier {
		case color(Color)
		case font(Font?)
		case fontSize(Double)
		case lineSpacing(Double)
	}
}

public extension Text {
	func foregroundColor(_ color: Color?) -> Text {
		textWithModifier(.color(color ?? .black))
	}
	
	func font(_ font: Font?) -> Text {
		textWithModifier(.font(font))
	}
	
	func fontSize(_ size: Double) -> Text {
		textWithModifier(.fontSize(size))
	}
	
	func lineSpacing(_ spacing: Double) -> Text {
		textWithModifier(.lineSpacing(spacing))
	}
	
	private func textWithModifier(_ modifier: Modifier) -> Text {
		let modifiers = self.modifiers + [modifier]
		return Text(content, modifiers: modifiers)
	}
}

extension Text: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
//		let drawable = TextDrawable(content: content, modifiers: modifiers)
//		parent.add(child: drawable)
	}
}
