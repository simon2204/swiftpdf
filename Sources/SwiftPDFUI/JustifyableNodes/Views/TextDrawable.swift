import SwiftPDF
import Foundation

final class TextDrawable: JustifiableNode {
	
	private let content: String
	
	private let modifiers: [Text.Modifier]
	
	private let lines: [String]
	
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
		self.modifiers = modifiers
		self.lines = content.components(separatedBy: "\n")
		self.font = .courier
		self.fontSize = 12
		self.lineSpacing = 0
		self.fontColor = .black
		
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
		maxWidth = font.width(of: content, size: fontSize)
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		
		// Count of lines that can fit in proposedHeight.
		let maxLineCount = Int((proposedHeight + lineSpacing) / (fontSize + lineSpacing))
		
		for line in lines where !line.isEmpty {
			
			let lineComponents = line
				.removeTrailingWhitespaces()
				.split(separator: " ", omittingEmptySubsequences: false)
			
			// The current longest line that has a width smaller or equal to `proposedWidth`.
			var longestFittingLine = ""
			
			var currentIndex = lineComponents.startIndex
			
			var currentLineComponent: String {
				String(lineComponents[currentIndex])
			}
			
			var canProcessNextComponent: Bool {
				currentIndex < lineComponents.endIndex
                && fittingLines.count <= maxLineCount
			}
			
			var currentIndexIsLastIndex: Bool {
				lineComponents.index(after: currentIndex) == lineComponents.endIndex
			}
			
			repeat {
				
				// First append leading whitespaces for each empty `currentLineComponent`.
				while canProcessNextComponent && currentLineComponent.isEmpty {
					longestFittingLine += " "
					currentIndex = lineComponents.index(after: currentIndex)
				}
				
                // Extending `longestFittingLine` by the `currentLineComponent`.
				let extendedLine = longestFittingLine + currentLineComponent
				
                // Line width of the extended line.
				let extendedLineWidth = font.width(of: extendedLine, size: fontSize)
				
				if extendedLineWidth <= proposedWidth {
                    // If `extendedLine` fits in the proposed width the `extendedLine`
                    // is now the new longestFittingLine.
					longestFittingLine = extendedLine
                    
                } else {
                    // If `extendedLine` does not fit, therefore `longestFittingLine`
                    // is now the longest fitting line for the proposed width,
                    // append it to `fittingLines`.
                    fittingLines.append(longestFittingLine.removeTrailingWhitespaces())
                    // `currentLineComponent` will be the start for the next line.
                    longestFittingLine = currentLineComponent
                }
            
				if currentIndexIsLastIndex {
					fittingLines.append(longestFittingLine.removeTrailingWhitespaces())
				}
				
                // Append whitespace for seperating each token.
				longestFittingLine += " "
				
				currentIndex = lineComponents.index(after: currentIndex)
				
			} while canProcessNextComponent
		}
		
		let longesLineWidth = fittingLines
			.map { font.width(of: $0, size: fontSize) }
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
			context.showTextLines(fittingLines, at: newOrigin)
		} else {
			context.showTextLines(fittingLines, at: origin)
		}
		
		context.restoreGState()
	}
}
