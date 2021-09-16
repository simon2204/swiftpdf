extension Double: ExpressibleAsPDFString {
    var pdfString: String {
        "\(self)"
    }
}
