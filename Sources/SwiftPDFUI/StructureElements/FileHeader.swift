struct FileHeader: ExpressibleAsPDFString {
    var pdfString: String {
        "%PDF–2.0" + Whitespace.crlf
    }
}
