protocol PDFDictionary: ExpressibleAsPDFObject {
    var dictionary: [Name : ExpressibleAsPDFObject] { get }
}

extension PDFDictionary {
    var pdfRepresentation: String {
        dictionary.pdfRepresentation
    }
}
