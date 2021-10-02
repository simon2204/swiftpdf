public struct Spacer: View {
	
	var minLength: Double?
	
	public init() {}
	
	public init(minLength: Double?) {
		self.minLength = minLength
	}
}

extension Spacer: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let drawable = SpacerDrawable(minLength: minLength)
        parent.add(child: drawable)
	}
}
