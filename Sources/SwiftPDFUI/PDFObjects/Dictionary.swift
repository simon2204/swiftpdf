import Foundation

extension Dictionary: PDFObject where Key == NamedObject, Value: PDFObject {
    var pdfData: Data {
        "<<"
        + Whitespace.crlf
        
        
        + Whitespace.crlf
        + ">>"
    }
}
