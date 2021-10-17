public struct BorderModifier: ViewModifier {
	let color: Color
    let width: Double
	
	public func body(content: Content) -> some View {
		content
	}
}

extension BorderModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
        let node = BorderNode(color: color, width: width)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
    func border(color: Color, width: Double = 1) -> ModifiedContent<Self, BorderModifier> {
		modifier(BorderModifier(color: color, width: width))
	}
}
