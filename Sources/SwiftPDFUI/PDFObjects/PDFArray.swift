import Foundation

protocol PDFArray: PDFObject {
    associatedtype Element: PDFObject
    var array: [Element] { get }
}

extension PDFArray {
    var pdfValue: Data {
        array.pdfValue
    }
}
