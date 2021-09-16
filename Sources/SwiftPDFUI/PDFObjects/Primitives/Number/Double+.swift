extension Double: ExpressibleAsPDFObject, Number {
    var pdfRepresentation: String {
        "\(self)"
    }
}
