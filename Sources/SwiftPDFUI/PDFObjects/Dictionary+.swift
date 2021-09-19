import Foundation

extension Dictionary: ExpressibleAsPDFData where Key == Name, Value == ExpressibleAsPDFString {
    var pdfData: Data {
        Data(pdfString.utf8)
    }
}

extension Dictionary: ExpressibleAsPDFString where Key == Name, Value == ExpressibleAsPDFString {
    var pdfString: String {
        "<<"
        + Whitespace.crlf
        + lazy.map { "\($0.key) \($0.value)" }.joined(separator: Whitespace.crlf.rawValue)
        + Whitespace.crlf
        + ">>"
    }
}
