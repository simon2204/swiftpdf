public struct ZStack<Content>: View where Content: View {
	let alignment: Alignment
	let content: () -> Content
	
	public init(
		alignment: Alignment = .center,
        @ViewBuilder content: @escaping () -> Content)
	{
		self.alignment = alignment
        self.content = content
	}
}

extension ZStack: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let node = ZStackDrawable(alignment: alignment)
		parent.add(child: node)
		content().unwrapped().buildTree(node)
	}
}
