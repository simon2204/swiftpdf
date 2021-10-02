public struct FrameModifier: ViewModifier {
	let width: Double?
	let height: Double?
	let alignment: Alignment
	
	public func body(content: Content) -> some View {
		content
	}
}

extension FrameModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = FrameNode(width: width, height: height, alignment: alignment)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
	func frame(width: Double? = nil, height: Double? = nil, alignment: Alignment = .center) -> ModifiedContent<Self, FrameModifier> {
		modifier(FrameModifier(width: width, height: height, alignment: alignment))
	}
}

