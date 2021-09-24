public struct HStack<Content>: View where Content: View {
	let alignment: VerticalAlignment
	let spacing: Double?
    let content: Content
    
    public init(
		alignment: VerticalAlignment = .center,
		spacing: Double? = nil,
		@ViewBuilder content: () -> Content)
	{
		self.alignment = alignment
		self.spacing = spacing
        self.content = content()
    }
}
