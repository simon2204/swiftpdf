extension Optional: View {}

extension Optional: PrimitiveView where Wrapped: View {
	func buildTree(_ parent: Node) {
		let drawable = OptionalDrawable()
		let node = Node(drawable)
		parent.children.append(node)
		
		if case let .some(view) = self {
			let primitive = view.unwrapped()
			primitive.buildTree(node)
		}
	}
}
