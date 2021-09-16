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
        + lazy.map { $0.key.name + " " + $0.value.pdfString }.joined(separator: Whitespace.crlf.rawValue)
        + Whitespace.crlf
        + ">>"
    }
}

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: [Name : ExpressibleAsPDFString]) {
        appendInterpolation(value.pdfString)
    }
}
