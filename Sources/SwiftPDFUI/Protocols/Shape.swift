public protocol Shape: View {
	func path(in rect: Rect) -> Path
}

extension Shape {
	public var body: some View {
		ShapeView(shape: self, style: .fill, color: .black)
	}
}

public extension Shape {
	func fill(_ color: Color) -> some View {
		ShapeView(shape: self, style: .fill, color: color)
	}
	
	func stroke(_ color: Color, lineWidth: Double = 1) -> some View {
		ShapeView(shape: self, style: .stroke(width: lineWidth), color: color)
	}
}
