extension Optional: View {}

extension Optional: PrimitiveView where Wrapped: View {
	func buildTree(_ parent: JustifiableNode) {
		if case let .some(view) = self {
            view.unwrapped().buildTree(parent)
		}
	}
}
