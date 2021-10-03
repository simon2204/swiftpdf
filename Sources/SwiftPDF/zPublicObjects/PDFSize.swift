public struct PDFSize {
    public var width: Double
    public var height: Double
    
    public init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
	
	public static let zero = PDFSize(width: 0, height: 0)
}

extension PDFSize: Equatable {}

extension PDFSize: Comparable {
	public static func < (lhs: PDFSize, rhs: PDFSize) -> Bool {
		(lhs.width * lhs.height).magnitude < (rhs.width * rhs.height).magnitude
	}
}
