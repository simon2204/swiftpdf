protocol ExpressibleAsPDFArray: ExpressibleAsPDFString {
    associatedtype Element: ExpressibleAsPDFString
    var pdfArray: [Element] { get }
}

extension ExpressibleAsPDFArray {
    var pdfString: String {
        pdfArray.pdfString
    }
}
