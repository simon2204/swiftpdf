final class ColorDrawable: JustifiableNode {
    
    private let color: Color
    
    init(color: Color) {
        self.color = color
    }
    
    override func draw(in context: GraphicsContext) {
        context.saveGState()
        context.setFillColor(color)
        context.addRect(Rect(origin: origin, size: size))
        context.fillPath()
        context.restoreGState()
    }
}
