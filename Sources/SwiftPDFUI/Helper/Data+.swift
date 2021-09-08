import Foundation

extension Data: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = value.data(using: .utf8)!
    }
}

extension Data: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = Swift.withUnsafeBytes(of: value) { Data($0) }
    }
}

extension Data {
    static func += (lhs: inout Data, rhs: String) {
        lhs += rhs.data
    }
}


