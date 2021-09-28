public protocol View {
    associatedtype Body: View
    var body: Body { get }
}

@_spi(SwiftPDFUI)
extension View where Body == Never {
	public var body: Never {
		fatalError()
	}
}

extension View {
    func unwrapped() -> PrimitiveView {
        if let primitive = self as? PrimitiveView {
            return primitive
        }
        
        if let primitive = self.body as? PrimitiveView {
            return primitive
        }
            
        return self.body.unwrapped()
    }
}
