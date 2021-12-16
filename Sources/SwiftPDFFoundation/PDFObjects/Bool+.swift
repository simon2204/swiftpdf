extension Bool: ExpressibleAsPDFString {
    var pdfString: String {
        self ? "true" : "false"
    }
}
