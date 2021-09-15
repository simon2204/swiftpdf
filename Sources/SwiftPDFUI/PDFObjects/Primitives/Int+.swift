extension Int: PDFObject {
    var pdfValue: String {
        "\(self)"
    }
}

extension Int {
    func formatted(integerLength: Int) -> String {
        self.formatted(.number.precision(.integerLength(integerLength)).grouping(.never))
    }
}
