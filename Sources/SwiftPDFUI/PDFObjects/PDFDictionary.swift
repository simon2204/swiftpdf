import Foundation

protocol PDFDictionary: PDFObject {
    var dictionary: [NamedObject : PDFObject] { get }
}

extension PDFDictionary {
    var pdfValue: Data {
        dictionary.pdfValue
    }
}
