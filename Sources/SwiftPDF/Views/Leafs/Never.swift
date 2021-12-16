extension Never: View {
	@_spi(SwiftPDF)
	public var body: Never {
		fatalError()
	}
}
