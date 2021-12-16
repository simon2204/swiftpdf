import SwiftPDFFoundation

final class ColorDrawable: JustifiableNode {
    
    private let color: PDFColor
    
    init(color: PDFColor) {
        self.color = color
		super.init()
		maxWidth = .infinity
		maxHeight = .infinity
    }
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		self.width = proposedWidth
		self.height = proposedHeight
	}
    
    override func draw(in context: GraphicsContext) {
        context.saveGState()
		context.setFillColor(color)
		context.addRect(frame)
        context.fillPath()
        context.restoreGState()
    }
}
