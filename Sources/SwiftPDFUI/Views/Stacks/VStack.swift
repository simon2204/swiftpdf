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

//extension VStack: PrimitiveView {
//    func buildTree(_ parent: JustifiyableNode) {
//		let drawable = VStackDrawable(alignment: alignment, spacing: spacing)
//        parent.append(drawable)
//        self.content().unwrapped().buildTree(drawable)
//    }
//}
