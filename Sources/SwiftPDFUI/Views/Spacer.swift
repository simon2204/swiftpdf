public struct Spacer: View {
	
	var minLength: Double?
	
	public init() {}
	
	public init(minLength: Double?) {
		self.minLength = minLength
	}
}

extension Spacer: PrimitiveView {
	func buildTree(_ parent: Node) {
		let drawable = SpacerDrawable(minLength: minLength)
		let node = Node(drawable)
		parent.children.append(node)
	}
}
