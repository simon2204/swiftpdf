public struct GeometryReader<Content>: View where Content: View {
	let content: (Rect) -> Content
	
	public init(content: @escaping (Rect) -> Content) {
		self.content = content
	}
}

extension GeometryReader: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		
		let node = GeometryReaderDrawable()
		
		parent.add(child: node)
		
		node.didLayout = { frame in
			content(frame).unwrapped().buildTree(node)
		}
	}
}
