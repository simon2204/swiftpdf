public struct Rectangle: Shape {
	
	public init() {}
	
	public func path(in rect: Rect) -> Path {
		Path { path in
			path.addRect(rect)
		}
	}
}
