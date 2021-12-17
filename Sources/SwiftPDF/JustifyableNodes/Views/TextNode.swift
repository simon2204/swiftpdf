import SwiftPDFFoundation
import Foundation

final class TextNode: JustifiableNode {
	
	private let content: String
	
	private var font: Font
	
	private var fontSize: Double
	
	private var lineSpacing: Double
	
	private var fontColor: Color
	
	private var leading: Double {
		fontSize + lineSpacing
	}
	
	// Lines that fit in proposedWith.
	private var fittingLines = [String]()
	
	init(content: String, modifiers: [Text.Modifier]) {
		self.content = content
		self.font = .courier
		self.fontSize = Default.fontSize
		self.lineSpacing = Default.lineSpacing
		self.fontColor = Default.color
		
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
	
	override func justifyBounds() {
		maxWidth = content.reduce(0) { $0 + font.width(of: $1, size: fontSize) }
		minHeight = fontSize
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		
		let lines = wordWrap(text: content, maxLineLength: proposedWidth) { char in
			font.width(of: char, size: fontSize)
		}
		
		fittingLines = lines
		
		let longesLineWidth = fittingLines
			.map { $0.reduce(0) { $0 + font.width(of: $1, size: fontSize) } }
			.max() ?? 0
		
		self.width = longesLineWidth
		
		if fittingLines.isEmpty {
			self.height = 0
		} else {
			let lineCount = Double(fittingLines.count)
			self.height = fontSize * lineCount + (lineCount - 1) * lineSpacing
		}
	}
	
	override func justify(x: Double) {
		self.x = x
	}
	
	override func justify(y: Double) {
		self.y = y
	}
	
	override func draw(in context: GraphicsContext) {
		context.saveGState()
		context.setFillColor(fontColor.pdfColor)
		context.setFont(.courier)
		context.setFontSize(fontSize)
		
		let leading = self.leading
		let lineCount = Double(fittingLines.count)
		
		if let metrics = PDFFont.courier.metrics {
			let descender = fontSize * Double(metrics.descender) / Double(metrics.unitsPerEm)
			let y = origin.y - descender + leading * (lineCount - 1)
			let newOrigin = Point(x: origin.x, y: y)
            context.showTextLines(fittingLines, at: newOrigin, leading: leading)
		} else {
			context.showTextLines(fittingLines, at: origin, leading: leading)
		}
		
		context.restoreGState()
	}
	
	
}
