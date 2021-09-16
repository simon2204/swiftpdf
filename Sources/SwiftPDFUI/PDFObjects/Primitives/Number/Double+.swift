extension Double: ExpressibleAsPDFString, Number {
    var pdfString: String {
        "\(self)"
    }
}
