struct FileHeader: PDFObject {
    var pdfValue: String {
        "%PDF–2.0" + Whitespace.crlf
    }
}
