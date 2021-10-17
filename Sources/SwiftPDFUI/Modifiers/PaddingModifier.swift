public struct PaddingModifier: ViewModifier {
	
	private let insets: EdgeInsets?
	
	public init(insets: EdgeInsets?) {
		self.insets = insets
	}
	
	public func body(content: Content) -> some View {
		content
	}
}

extension PaddingModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = PaddingDrawable(insets: insets)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
	func padding(_ edges: Edge.Set = .all, _ length: Double? = nil) -> some View {
		let insets = length.map { length -> EdgeInsets in
			
			var insets = EdgeInsets()
			
			if edges.contains(.leading) {
				insets.leading = length
			}
			
			if edges.contains(.trailing) {
				insets.trailing = length
			}
			
			if edges.contains(.top) {
				insets.top = length
			}
			
			if edges.contains(.bottom) {
				insets.bottom = length
			}
			
			return insets
		}
		
		return modifier(PaddingModifier(insets: insets))
	}
	
	func padding(_ length: Double) -> some View {
		modifier(PaddingModifier(insets: EdgeInsets(all: length)))
	}
	
	func padding(_ insets: EdgeInsets) -> some View {
		modifier(PaddingModifier(insets: insets))
	}
}
