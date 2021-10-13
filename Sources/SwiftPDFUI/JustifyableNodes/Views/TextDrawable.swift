import SwiftPDF

final class TextDrawable: JustifiableNode {
	
	let content: String
	
	let modifiers: [Text.Modifier]
	
	let components: [String]
	
	var font: Font
	
	var fontSize: Double
	
	var lineSpacing: Double
	
	var fontColor: Color
	
	init(content: String, modifiers: [Text.Modifier]) {
		self.content = content
		self.modifiers = modifiers
		self.components = content.components(separatedBy: "\n")
		
		self.font = .courier
		self.fontSize = 12
		self.lineSpacing = 0
		self.fontColor = .blue
		
		for modifier in modifiers {
			switch modifier {
			case let .font(font):
				self.font = font ?? .courier
				
			case let .color(color):
				self.fontColor = color
				
			case let .fontSize(size):
				self.fontSize = size
				
			case let .lineSpacing(spacing):
				self.lineSpacing = spacing
			}
		}
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		maxWidth = font.width(of: content, size: fontSize) ?? 0
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justifyWidth(proposedWidth: Double) {
		var width: Double = 0
		
		for component in components {
			if let componentWidth = font.width(of: component, size: fontSize) {
				width = max(width, componentWidth)
			}
		}
		
		self.size.width = width
	}
	
	override func justifyHeight(proposedHeight: Double) {
		self.size.height = fontSize
	}
	
	override func draw(in context: GraphicsContext) {
		context.saveGState()
		context.setFillColor(fontColor.pdfColor)
		context.setFont(.courier)
		context.setFontSize(fontSize)
		 
		if let metrics = PDFFont.courier.metrics {
			let descender = fontSize * Double(metrics.descender) / Double(metrics.unitsPerEm)
			let y = origin.y - descender
			let newOrigin = Point(x: origin.x, y: y)
			context.showTextLines(components, at: newOrigin)
		} else {
			context.showTextLines(components, at: origin)
		}
		
		context.restoreGState()
	}
	
	
	
}
