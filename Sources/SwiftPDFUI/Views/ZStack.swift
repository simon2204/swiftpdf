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
    func buildTree(_ parent: NodeProtocol) {
		let drawable = ZStackDrawable(alignment: alignment)
        parent.append(drawable)
        self.content().unwrapped().buildTree(drawable)
    }
}
