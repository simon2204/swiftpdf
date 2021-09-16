extension Double: PDFObject, Number {
    var pdfValue: String {
        "\(self)"
    }
}
