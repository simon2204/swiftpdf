extension Bool: ExpressibleAsPDFObject {
    var pdfRepresentation: String {
        "\(self)"
    }
}
