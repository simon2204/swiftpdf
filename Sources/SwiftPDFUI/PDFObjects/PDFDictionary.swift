protocol PDFDictionary: ExpressibleAsPDFString {
    var dictionary: [Name : ExpressibleAsPDFString] { get }
}

extension PDFDictionary {
    var pdfString: String {
        dictionary.pdfString
    }
}
