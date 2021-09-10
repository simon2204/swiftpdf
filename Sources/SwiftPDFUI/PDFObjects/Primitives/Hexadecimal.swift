import Foundation

struct Hexadecimal: PDFObject {
    let value: String
    
    var pdfData: Data {
        "<\(value)>".pdfData
    }
}
