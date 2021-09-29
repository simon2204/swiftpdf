public struct Spacer: View {
	
	var minLength: Double?
	
	public init() {}
	
	public init(minLength: Double?) {
		self.minLength = minLength
	}
}

extension Spacer: PrimitiveView {
	func buildTree(_ parent: NodeProtocol) {
		let drawable = SpacerDrawable(minLength: minLength)
		parent.append(drawable)
	}
}
