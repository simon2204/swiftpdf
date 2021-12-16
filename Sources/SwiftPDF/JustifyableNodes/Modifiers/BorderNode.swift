final class BorderNode: JustifiableNode {
    
    /// Farbe der Umrandung.
	let color: Color
    
    /// Breite der Linie, der Umrandung.
    let _width: Double
	
    init(color: Color, width: Double) {
		self.color = color
        self._width = width
	}
	
	override func draw(in context: GraphicsContext) {
		super.draw(in: context)
		
        // Offset, um die Umrandung vollständig innerhalb
        // eines Rahmens zu zeichnen, so dass die Linie
        // bei einer dickeren Breite nicht über den Rahmen
        // übersteht.
        let offset = self._width / 2
        
        // Ursprung der zu zeichnenden Umrandung.
        let origin = Point(x: x + offset, y: y + offset)
        
        // Größe der Umrandung, der mit der Breite der gezeichneten Linie,
        // nicht die Größe des Rahmens übersteigt, um den die Umrandung
        // gezeichnet wird.
        let size = Size(width: width - self._width, height: height - self._width)
        
        // Rechteck mit der Positionierung und Dimensionierung der Umrandung.
		let rect = Rect(origin: origin, size: size)
		
        // Zeichnet die Umrandung.
		context.saveGState()
		context.setStrokeColor(color.pdfColor)
		context.setLineWidth(_width)
		context.addRect(rect)
		context.strokePath()
		context.restoreGState()
	}
}
