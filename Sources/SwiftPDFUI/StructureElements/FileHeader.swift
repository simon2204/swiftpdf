struct FileHeader: ExpressibleAsPDFObject {
    var pdfRepresentation: String {
        "%PDF–2.0" + Whitespace.crlf
    }
}
