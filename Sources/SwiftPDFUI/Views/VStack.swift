public struct VStack<Content>: View where Content: View {
	let alignment: HorizontalAlignment
	let spacing: Double?
	let content: () -> Content
	
	public init(
		alignment: HorizontalAlignment = .center,
		spacing: Double? = nil,
        @ViewBuilder content: @escaping () -> Content)
	{
		self.alignment = alignment
		self.spacing = spacing
		self.content = content
	}
}

extension VStack: PrimitiveView {
    func buildTree(_ parent: Node) {
        let node = Node(self)
        parent.children.append(node)
        self.content().unwrapped().buildTree(node)
    }
}
