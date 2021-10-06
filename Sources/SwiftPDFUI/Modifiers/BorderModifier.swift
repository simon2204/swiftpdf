public struct BorderModifier: ViewModifier {
	let color: Color
	
	public func body(content: Content) -> some View {
		content
	}
}

extension BorderModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = BorderNode(color: color)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
	func border(_ color: Color = .black) -> ModifiedContent<Self, BorderModifier> {
		modifier(BorderModifier(color: color))
	}
}
