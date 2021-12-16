import SwiftPDFFoundation

final class ShapeNode<Content>: JustifiableNode where Content: Shape {
	
	let shape: Content
	let style: ShapeView<Content>.Style
	let color: Color
	
	init(shape: Content, style: ShapeView<Content>.Style, color: Color) {
		self.shape = shape
		self.style = style
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
		
		let elements = shape.path(in: frame).segments
		
		for element in elements {
			switch element {
			case .move(to: let point):
				context.move(to: point)
				
			case .line(to: let point):
				context.addLine(to: point)
				
			case .lines(between: let points):
				context.addLines(between: points)
				
			case .rect(let rect):
				context.addRect(rect)
				
			case .ellipse(in: let rect):
				context.addEllipse(in: rect)
				
			case let .curve(to: end, control1: c1, control2: c2):
				context.addCurve(to: end, control1: c1, control2: c2)
				
			case .closeSubpath:
				context.closePath()
			}
		}
		
		switch style {
		case .fill:
			context.setFillColor(color.pdfColor)
			context.fillPath()
			
		case .stroke(let width):
			context.setLineWidth(width)
			context.setStrokeColor(color.pdfColor)
			context.strokePath()
		}
		
		context.restoreGState()
	}
}
