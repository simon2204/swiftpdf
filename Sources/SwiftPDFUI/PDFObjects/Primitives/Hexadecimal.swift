struct Hexadecimal: ExpressibleAsPDFString {
    let value: String
    
    var pdfString: String {
        "<\(value)>"
    }
}
