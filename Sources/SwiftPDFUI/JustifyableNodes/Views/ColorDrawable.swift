import SwiftPDF

final class ColorDrawable: JustifiableNode {
    
    private let color: PDFColor
    
    init(color: PDFColor) {
        self.color = color
    }
	
	override func getBoundary() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		maxWidth = .infinity
		maxHeight = .infinity
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
