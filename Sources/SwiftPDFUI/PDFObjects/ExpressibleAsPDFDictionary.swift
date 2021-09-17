protocol ExpressibleAsPDFDictionary: ExpressibleAsPDFString {
    var dictionary: [Name : ExpressibleAsPDFString] { get }
}

extension ExpressibleAsPDFDictionary {
    var pdfString: String {
        dictionary.pdfString
    }
}
