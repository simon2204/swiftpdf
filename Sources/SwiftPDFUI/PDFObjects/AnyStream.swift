struct AnyStream: ExpressibleAsPDFStream {
	private let wrapped: [ExpressibleAsPDFData]
	
	init(_ stream: ExpressibleAsPDFStream) {
		self.wrapped = stream.pdfStream
	}
	
	var pdfStream: [ExpressibleAsPDFData] {
		self.wrapped
	}
}
