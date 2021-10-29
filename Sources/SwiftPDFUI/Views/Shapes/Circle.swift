public struct Circle: Shape {
	
	public init() {}
	
	public func path(in rect: Rect) -> Path {
		var path = Path()
		
		let width = min(rect.width, rect.height)
		
		let x = rect.origin.x + (rect.width - width) / 2
		let y = rect.origin.y + (rect.height - width) / 2
		
		let origin = Point(x: x, y: y)
		
		let size = Size(width: width, height: width)
		
		let square = Rect(origin: origin, size: size)
		
		path.addEllipse(in: square)
		
		return path
	}
}
