public struct ZStack<Content>: View where Content: View {
	let alignment: Alignment
	let content: Content
	
	public init(
		alignment: Alignment = .center,
		@ViewBuilder content: () -> Content)
	{
		self.alignment = alignment
		self.content = content()
	}
}
