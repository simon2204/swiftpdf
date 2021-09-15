protocol PDFDictionary: PDFObject {
    var dictionary: [Name : PDFObject] { get }
}

extension PDFDictionary {
    var pdfValue: String {
        dictionary.pdfValue
    }
}
