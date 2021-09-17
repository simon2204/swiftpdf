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

//extension String.StringInterpolation {
//	/// Interpolates the given value’s textual representation into the string literal being created.
//	mutating func appendInterpolation<Value: ExpressibleAsPDFString>(_ value: Value) {
//		appendInterpolation(value.pdfString)
//	}
//}
