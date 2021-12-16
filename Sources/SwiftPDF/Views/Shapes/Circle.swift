/// Die Form eines Kreises.
public struct Circle: Shape {
	
	public init() {}
	
	public func path(in rect: Rect) -> Path {
        
        // Pfad des Kreises.
		var path = Path()
		
        // Breite des Kreises.
		let width = min(rect.width, rect.height)
		
        // Zentriert den Kreis auf der x-Achse von `rect`.
		let x = rect.origin.x + (rect.width - width) / 2
        
        // Zentriert den Kreis auf der y-Achse von `rect`.
		let y = rect.origin.y + (rect.height - width) / 2
		
		let origin = Point(x: x, y: y)
		
		let size = Size(width: width, height: width)
		
		let square = Rect(origin: origin, size: size)
		
		path.addEllipse(in: square)
		
		return path
	}
}
