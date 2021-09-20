struct AnyStream: ExpressibleAsPDFStream {
	private let wrapped: [ExpressibleAsPDFData]
	
	init<S: ExpressibleAsPDFStream>(_ stream: S) {
		self.wrapped = stream.pdfStream
	}
	
	var pdfStream: [ExpressibleAsPDFData] {
		self.wrapped
	}
}
