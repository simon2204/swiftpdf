public struct PDFPoint {
    public var x: Double
    public var y: Double
    
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
	
	public static let zero = PDFPoint(x: 0, y: 0)
}

extension PDFPoint: Equatable {}
