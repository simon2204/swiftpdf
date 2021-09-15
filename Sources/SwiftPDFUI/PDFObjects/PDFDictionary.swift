protocol PDFDictionary: PDFObject {
    var dictionary: [NamedObject : PDFObject] { get }
}

extension PDFDictionary {
    var pdfValue: String {
        dictionary.pdfValue
    }
}
