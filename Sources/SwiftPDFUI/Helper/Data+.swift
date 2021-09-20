import Foundation

extension Data: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
		self = Data(value.utf8)
    }
}

extension Data: ExpressibleByStringInterpolation { }

extension Data {
    static func += (lhs: inout Data, rhs: String) {
        lhs += Data(rhs.utf8)
    }
    
    static func + (lhs: Data, rhs: String) -> Data {
        lhs + Data(rhs.utf8)
    }
    
    static func + (lhs: String, rhs: Data) -> Data {
		Data(lhs.utf8) + rhs
    }
}


extension Data {
	func hexEncodedString() -> String {
		self.map { String(format: "%02hhX", $0) }.joined()
	}
}


