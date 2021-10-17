final class BorderNode: JustifiableNode {
	let color: Color
    let _width: Double
	
    init(color: Color, width: Double) {
		self.color = color
        self._width = width
	}
	
	override func draw(in context: GraphicsContext) {
		super.draw(in: context)
		
        let offset = self._width / 2
        
        let origin = Point(x: x + offset, y: y + offset)
        let size = Size(width: width - self._width, height: height - self._width)
		let rect = Rect(origin: origin, size: size)
		
		context.saveGState()
		context.setStrokeColor(color.pdfColor)
		context.setLineWidth(_width)
		context.addRect(rect)
		context.strokePath()
		context.restoreGState()
	}
}
