struct IndirectReference<Object> {
	
	private let indirectObject: IndirectObject<Object>
	
	var id: Int {
		indirectObject.objectNumber
	}
	
	init(_ indirectObject: IndirectObject<Object>) {
		self.indirectObject = indirectObject
	}
}

extension IndirectReference: ExpressibleAsPDFString {
	var pdfString: String {
		"\(id) 0 R"
	}
}

