import Foundation

extension Dictionary: PDFObject where Key == NamedObject, Value == PDFObject {
    var pdfData: Data {
        "<<"
        + Whitespace.crlf
        + lazy.map { $0.key.name + " " + $0.value.pdfData }.joined(separator: Whitespace.crlf)
        + Whitespace.crlf
        + ">>"
    }
}
