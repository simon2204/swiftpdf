import Foundation

struct Hexadecimal: PDFObject {
    let value: String
    
    var pdfValue: Data {
        "<\(value)>".pdfValue
    }
}
