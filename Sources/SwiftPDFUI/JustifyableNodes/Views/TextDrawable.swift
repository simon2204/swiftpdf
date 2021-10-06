//final class TextDrawable: DrawableNode {
//	
//	var origin: Point = .zero
//	
//	var size: Size = .zero
//    
//    var children: [NodeProtocol]?
//	
//	var content: String
//	
//	var modifiers: [Text.Modifier]
//    
//    init(content: String, modifiers: [Text.Modifier]) {
//        self.content = content
//        self.modifiers = modifiers
//    }
//	
//    func wantedWidthForProposedDimentions(width: Double, height: Double) -> Double {
//        0
//    }
//    
//    func layoutVertically(width: Double, height: Double) -> Double {
//        0
//    }
//    
//    
//}
//
//extension TextDrawable: CustomStringConvertible {}

import SwiftPDF

final class TextDrawable: JustifiableNode {
	
	let content: String
	
	let modifiers: [Text.Modifier]
	
	lazy var fontSize: Double = {
		for modifier in modifiers {
			if case let .size(size) = modifier {
				return size
			}
		}
		return 12.0
	}()
	
	lazy var fontColor: Color = {
		for modifier in modifiers {
			if case let .color(color) = modifier {
				return color
			}
		}
		return .black
	}()
	
	init(content: String, modifiers: [Text.Modifier]) {
		self.content = content
		self.modifiers = modifiers
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		maxWidth = PDFFont.courier.width(of: content, size: fontSize)
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		self.size.width = maxWidth
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		self.size.height = fontSize
	}
	
	override func draw(in context: GraphicsContext) {
		context.saveGState()
		context.setFillColor(fontColor.pdfColor)
		context.setFont(.courier)
		context.setFontSize(fontSize)
		let y = origin.y + size.height / 4
		context.showText(content, at: Point(x: origin.x, y: y))
		context.restoreGState()
	}
}
