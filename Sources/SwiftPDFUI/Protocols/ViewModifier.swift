public protocol ViewModifier {
	associatedtype Body: View
	typealias Content = _ViewModifier_Content
	func body(content: Content) -> Self.Body
}

@_spi(SwiftPDFUI)
extension ViewModifier where Body == Never {
	public func body(content: Content) -> Body {
		fatalError()
	}
}

public extension View {
	func modifier<Modifier>(_ modifier: Modifier) -> ModifiedContent<Self, Modifier> {
		.init(content: self, modifier: modifier)
	}
}
