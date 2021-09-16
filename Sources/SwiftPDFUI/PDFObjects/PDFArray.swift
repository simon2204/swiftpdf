protocol PDFArray: ExpressibleAsPDFString {
    associatedtype Element: ExpressibleAsPDFString
    var array: [Element] { get }
}

extension PDFArray {
    var pdfString: String {
        array.pdfString
    }
}
