import SwiftPDF

final class ColorDrawable: JustifiableNode {
    
    private let color: PDFColor
    
    init(color: PDFColor) {
        self.color = color
		super.init()
		maxWidth = .infinity
		maxHeight = .infinity
    }
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		self.size.width = proposedWidth
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		self.size.height = proposedHeight
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
    
    override func draw(in context: GraphicsContext) {
        context.saveGState()
		context.setFillColor(color)
        context.addRect(Rect(origin: origin, size: size))
        context.fillPath()
        context.restoreGState()
    }
}
