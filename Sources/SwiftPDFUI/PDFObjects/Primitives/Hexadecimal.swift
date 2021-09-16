struct Hexadecimal: ExpressibleAsPDFObject {
    let value: String
    
    var pdfRepresentation: String {
        "<\(value)>"
    }
}
