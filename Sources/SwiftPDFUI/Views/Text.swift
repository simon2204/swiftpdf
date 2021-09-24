import SwiftPDF

public typealias Font = PDFFont

public struct Text {
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
		case color(Color?)
		case font(Font?)
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
		textWithModifier(.color(color))
	}
	
	func font(_ font: Font?) -> Text {
		textWithModifier(.font(font))
	}
	
	func underline(_ active: Bool = true, color: Color? = nil) -> Text {
		textWithModifier(.underline(active, color))
	}
	
	private func textWithModifier(_ modifier: Modifier) -> Text {
		let modifiers = self.modifiers + [modifier]
		return Text(content, modifiers: modifiers)
	}
}


			
