public struct ModifiedContent<Content, Modifier>: View where Content: View, Modifier: ViewModifier {
	var content: Content
	var modifier: Modifier
}

extension ModifiedContent: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		if let primitiveModifier = modifier as? PrimitiveModifier {
			primitiveModifier.buildTree(parent, content: content.unwrapped())
		} else {
			let content = _ViewModifier_Content(view: content)
			let view = modifier.body(content: content)
			view.unwrapped().buildTree(parent)
		}
	}
}
