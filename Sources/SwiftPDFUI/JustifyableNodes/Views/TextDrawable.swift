import SwiftPDF

final class TextDrawable: JustifiableNode {
	
	let content: String
	
	let modifiers: [Text.Modifier]
	
	var subcontent: [Substring] = []
	
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
		maxWidth = PDFFont.courier.width(of: content, size: fontSize) ?? 0
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		var width: Double = 0
		
		subcontent = content.split(separator: "\n", omittingEmptySubsequences: false)
		
		for subcontent in subcontent {
			if let subcontentWidth = PDFFont.courier.width(of: String(subcontent), size: fontSize) {
				width = max(width, subcontentWidth)
			}
		}
		
		self.size.width = width
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
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
			context.showTextLines(subcontent, at: newOrigin)
		} else {
			context.showTextLines(subcontent, at: origin)
		}
		
		context.restoreGState()
	}
}
