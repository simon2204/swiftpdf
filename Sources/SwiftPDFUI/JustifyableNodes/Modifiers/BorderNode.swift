final class BorderNode: JustifiableNode {
	let color: Color
	
	init(color: Color) {
		self.color = color
	}
	
	override func draw(in context: GraphicsContext) {
		super.draw(in: context)
		context.saveGState()
		context.setStrokeColor(color.pdfColor)
		context.setLineWidth(1)
		context.addRect(Rect(origin: origin, size: size))
		context.strokePath()
		context.restoreGState()
	}
}
