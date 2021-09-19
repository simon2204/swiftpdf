extension Double: ExpressibleAsPDFString {
    var pdfString: String {
        String(self)
    }
}
