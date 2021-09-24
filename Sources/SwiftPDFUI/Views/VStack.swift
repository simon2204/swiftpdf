public struct VStack<Content>: View where Content: View {
	let alignment: HorizontalAlignment
	let spacing: Double?
	let content: Content
	
	public init(
		alignment: HorizontalAlignment = .center,
		spacing: Double? = nil,
		@ViewBuilder content: () -> Content)
	{
		self.alignment = alignment
		self.spacing = spacing
		self.content = content()
	}
}
