public struct RoundedRectangle: Shape {
	
	let cornerRadius: Double
	
	public init(cornerRadius: Double) {
		self.cornerRadius = cornerRadius
	}
	
	public func path(in rect: Rect) -> Path {
		var path = Path()
		
		let magicNumber = 0.55225
		let magicOffset = magicNumber * cornerRadius
		
		let p1 = Point(x: rect.minX + cornerRadius, y: rect.minY)
		let c1 = Point(x: p1.x - magicOffset, y: p1.y)
		
		let p2 = Point(x: rect.minX, y: rect.minY + cornerRadius)
		let c2 = Point(x: p2.x, y: p2.y - magicOffset)
		
		let p3 = Point(x: rect.minX, y: rect.maxY - cornerRadius)
		let c3 = Point(x: p3.x, y: p3.y + magicOffset)
		
		let p4 = Point(x: rect.minX + cornerRadius, y: rect.maxY)
		let c4 = Point(x: p4.x - magicOffset, y: p4.y)
		
		let p5 = Point(x: rect.maxX - cornerRadius, y: rect.maxY)
		let c5 = Point(x: p5.x + magicOffset, y: p5.y)
		
		let p6 = Point(x: rect.maxX, y: rect.maxY - cornerRadius)
		let c6 = Point(x: p6.x, y: p6.y + magicOffset)
		
		let p7 = Point(x: rect.maxX, y: rect.minY + cornerRadius)
		let c7 = Point(x: p7.x, y: p7.y - magicOffset)
		
		let p8 = Point(x: rect.maxX - cornerRadius, y: rect.minY)
		let c8 = Point(x: p8.x + magicOffset, y: p8.y)
		
		path.move(to: p1)
		path.addCurve(to: p2, control1: c1, control2: c2)
		path.addLine(to: p3)
		path.addCurve(to: p4, control1: c3, control2: c4)
		path.addLine(to: p5)
		path.addCurve(to: p6, control1: c5, control2: c6)
		path.addLine(to: p7)
		path.addCurve(to: p8, control1: c7, control2: c8)
		path.addLine(to: p1)
		
		return path
	}
}
