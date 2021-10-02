public struct _ViewModifier_Content: View {
	let view: AnyView
	
	init<V>(view: V) where V: View {
		self.view = AnyView(view)
	}
}

extension _ViewModifier_Content: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		view.buildTree(parent)
	}
}
