/// Eine `View`, die die Konfiguration eines `Shape`s behinhaltet.
///
/// Diese `View` beinhaltet eine Form, sowie die Farbe, mit der sie
/// gefüllt oder umrissen wird.
struct ShapeView<Content>: View where Content: Shape {
	var shape: Content
	var style: Style
	var color: Color
    
    init(shape: Content, style: Style = .fill, color: Color = .black) {
		self.shape = shape
		self.style = style
		self.color = color
	}
	
	enum Style {
		case fill
		case stroke(width: Double)
	}
}

extension ShapeView: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let node = ShapeNode(shape: shape, style: style, color: color)
		parent.add(child: node)
	}
}

extension ShapeView {
	public var body: some View {
		self
	}
}


