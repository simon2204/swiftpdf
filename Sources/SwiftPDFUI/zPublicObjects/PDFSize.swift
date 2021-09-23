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
