protocol PDFArray: ExpressibleAsPDFObject {
    associatedtype Element: ExpressibleAsPDFObject
    var array: [Element] { get }
}

extension PDFArray {
    var pdfRepresentation: String {
        array.pdfRepresentation
    }
}
