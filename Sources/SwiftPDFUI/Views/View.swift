public protocol View {
    associatedtype Body: View
    var body: Body { get }
}

@_spi(SwiftPDFUI)
extension View where Body == Never {
	public var body: Never {
		fatalError()
	}
}
