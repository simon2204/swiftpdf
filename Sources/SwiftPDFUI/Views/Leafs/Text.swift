import SwiftPDF

@frozen
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
	@usableFromInline
	enum Modifier {
		case color(Color)
		case font(Font?)
		case size(Double)
//		case italic
//		case weight(Font.Weight?)
		case kerning(Double)
		case tracking(Double)
//		case baseline(Double)
//		case rounded
		case underline(Bool, Color?)
	}
}

public extension Text {
	func foregroundColor(_ color: Color?) -> Text {
		textWithModifier(.color(color ?? .black))
	}
	
	func font(_ font: Font?) -> Text {
		textWithModifier(.font(font))
	}
	
	func size(_ size: Double) -> Text {
		textWithModifier(.size(size))
	}
	
//	func underline(_ active: Bool = true, color: Color? = nil) -> Text {
//		textWithModifier(.underline(active, color))
//	}
	
	private func textWithModifier(_ modifier: Modifier) -> Text {
		let modifiers = self.modifiers + [modifier]
		return Text(content, modifiers: modifiers)
	}
}

extension Text: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let drawable = TextDrawable(content: content, modifiers: modifiers)
		parent.add(child: drawable)
	}
}
