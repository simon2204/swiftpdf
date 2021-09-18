struct HexadecimalString {
    let value: String
    
    
}

extension HexadecimalString: ExpressibleAsPDFString {
    var pdfString: String {
        "<\(value)>"
    }
}
