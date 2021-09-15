struct Hexadecimal: PDFObject {
    let value: String
    
    var pdfValue: String {
        "<\(value)>"
    }
}
