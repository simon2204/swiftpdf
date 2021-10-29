public struct BackgroundModifier<Background, Foreground>: ViewModifier where Background: View, Foreground: View {
	
	let alignment: Alignment
	
	let background: () -> Background
	
	let foreground: Foreground
	
	public func body(content: Content) -> some View {
		content
	}
}

extension BackgroundModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = BackgroundNode(alignment: alignment)
		parent.add(child: node)
		foreground.unwrapped().buildTree(node)
		background().unwrapped().buildTree(node)
	}
}

public extension View {
	func background<V>(alignment: Alignment = .center, _ content: @escaping () -> V) -> some View where V : View {
		modifier(BackgroundModifier(alignment: alignment, background: content, foreground: self))
	}
}
