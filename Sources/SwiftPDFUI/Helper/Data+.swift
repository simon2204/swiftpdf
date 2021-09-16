import Foundation

extension Data: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = value.data(using: .utf8)!
    }
}

extension Data: ExpressibleByStringInterpolation { }

extension Data {
    static func += (lhs: inout Data, rhs: String) {
        lhs += rhs.data(using: .utf8)!
    }
    
    static func + (lhs: Data, rhs: String) -> Data {
        lhs + rhs.data(using: .utf8)!
    }
    
    static func + (lhs: String, rhs: Data) -> Data {
        lhs.data(using: .utf8)! + rhs
    }
}
