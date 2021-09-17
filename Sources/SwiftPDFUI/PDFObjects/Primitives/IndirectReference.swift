struct IndirectReference<Object>: ExpressibleAsPDFString {
	let id: Int
	
	var pdfString: String {
		"\(id) 0 R"
	}
}

