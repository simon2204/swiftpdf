protocol ExpressibleAsPDFDictionary: ExpressibleAsPDFString {
    var pdfDictionary: [Name : ExpressibleAsPDFString] { get }
}

extension ExpressibleAsPDFDictionary {
    var pdfString: String {
        pdfDictionary.pdfString
    }
}
