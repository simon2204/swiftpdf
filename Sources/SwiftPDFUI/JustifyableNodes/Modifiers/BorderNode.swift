final class BorderNode: JustifiableNode {
	let color: Color
	
	init(color: Color) {
		self.color = color
	}
	
	override func draw(in context: GraphicsContext) {
		super.draw(in: context)
		
		let origin = Point(x: x, y: y)
		let size = Size(width: width, height: height)
		let rect = Rect(origin: origin, size: size)
		
		context.saveGState()
		context.setStrokeColor(color.pdfColor)
		context.setLineWidth(1)
		context.addRect(rect)
		context.strokePath()
		context.restoreGState()
	}
}
