public struct PaddingModifier: ViewModifier {
	let length: Double?
	
	public func body(content: Content) -> some View {
		content
	}
}

extension PaddingModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = PaddingDrawable(length: length)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
	func padding(_ length: Double? = nil) -> ModifiedContent<Self, PaddingModifier> {
		modifier(PaddingModifier(length: length))
	}
}
