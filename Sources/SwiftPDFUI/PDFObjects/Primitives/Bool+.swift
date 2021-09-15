extension Bool: PDFObject {
    var pdfValue: String {
        self ? "true" : "false"
    }
}
