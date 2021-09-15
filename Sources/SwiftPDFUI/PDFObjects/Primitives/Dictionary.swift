import Foundation

extension Dictionary: PDFObject where Key == NamedObject, Value == PDFObject {
    var pdfValue: Data {
        "<<"
        + Whitespace.crlf
        + lazy.map { $0.key.name + " " + $0.value.pdfValue }.joined(separator: Whitespace.crlf)
        + Whitespace.crlf
        + ">>"
    }
}
