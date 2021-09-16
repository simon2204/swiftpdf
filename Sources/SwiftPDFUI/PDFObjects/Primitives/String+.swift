extension String: ExpressibleAsPDFString {
    var pdfString: String {
        self
    }
}

extension String {
    static func += (lhs: inout String, rhs: Whitespace) {
        lhs += rhs.rawValue
    }
    
    static func + (lhs: String, rhs: Whitespace) -> String {
        lhs + rhs.rawValue
    }
    
    static func + (lhs: Whitespace, rhs: String) -> String {
        lhs.rawValue + rhs
    }
}

extension Sequence where Element == String {
    func joined(seperator: Whitespace) -> String {
        joined(separator: seperator.rawValue)
    }
}
