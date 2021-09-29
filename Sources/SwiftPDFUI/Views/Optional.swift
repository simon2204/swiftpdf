extension Optional: View {}

extension Optional: PrimitiveView where Wrapped: View {
	func buildTree(_ parent: NodeProtocol) {
		let drawable = OptionalDrawable()
		parent.append(drawable)
		
		if case let .some(view) = self {
			let primitive = view.unwrapped()
			primitive.buildTree(drawable)
		}
	}
}
