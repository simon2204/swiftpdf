public struct EmptyShape: View {
    public init() {}
	
	@_spi(SwiftPDFUI)
	public var body: Never {
		fatalError()
	}
}


