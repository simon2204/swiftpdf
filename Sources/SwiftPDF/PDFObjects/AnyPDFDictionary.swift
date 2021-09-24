//struct AnyPDFDictionary: ExpressibleAsPDFDictionary {
//	private var elements: [(Name, ExpressibleAsPDFString)]
//	
//	var pdfDictionary: [Name : AnyExpressibleAsPDFString]  {
//		elements
//			.lazy
//			.map { ($0, AnyExpressibleAsPDFString($1)) }
//			.reduce(into: [Name : AnyExpressibleAsPDFString](minimumCapacity: elements.count)) {
//				(partialResult, entry) in
//				let (key, value) = entry
//				partialResult[key] = value
//			}
//	}
//}
//
//extension AnyPDFDictionary: ExpressibleByDictionaryLiteral {
//	init(dictionaryLiteral elements: (Name, ExpressibleAsPDFString)...) {
//		self.elements = elements
//	}
//}
