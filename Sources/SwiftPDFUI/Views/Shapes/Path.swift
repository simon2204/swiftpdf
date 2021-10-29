public struct Path {
	
	var elements: [Element] = []
	
	enum Element: Equatable {
		case move(to: Point)
		case line(to: Point)
		case lines(between: [Point])
		case rect(Rect)
		case ellipse(in: Rect)
		case curve(to: Point, control1: Point, control2: Point)
		case closeSubpath
	}
	
	public init() {}
	
	public init(_ callback: (inout Path) -> ()) {
		var base = Path()
		callback(&base)
		self = base
	}
	
	/// Begins a new subpath at the specified point.
	///
	/// The specified point becomes the start point of a new subpath.
	/// The current point is set to this start point.
	///
	/// - Parameter point: The point, in user space coordinates, at which to start a new subpath.
	///
	public mutating func move(to point: Point) {
		elements.append(.move(to: point))
	}
	
	/// Appends a straight line segment from the current point to the specified point.
	///
	/// After adding the line segment, the current point is set to the endpoint of the line segment.
	///
	/// - Parameter point: The location, in user space coordinates, for the end of the new line segment.
	///
	public mutating func addLine(to point: Point) {
		elements.append(.line(to: point))
	}
	
	/// Adds a sequence of connected straight-line segments to the current path.
	///
	/// Calling this convenience method is equivalent to calling the ``move(to:)``
	/// method with the first value in the points array,
	/// then calling the ``addLine(to:)``
	/// method for each subsequent point until the array is exhausted.
	/// After calling this method, the path's current point is the last point in the array.
	///
	/// - Parameter points:
	/// An array of values that specify the start and end points of the line segments to draw.
	/// Each point in the array specifies a position in user space.
	/// The first point in the array specifies the initial starting point.
	///
	public mutating func addLines(between points: [Point]) {
		elements.append(.lines(between: points))
	}
	
	/// Adds a rectangular path to the current path.
	///
	/// This is a convenience function that adds a rectangle to a path,
	/// starting by moving to the bottom left corner
	/// and then adding lines counter-clockwise to create a rectangle,
	/// closing the subpath.
	///
	/// - Parameter rect: A rectangle, specified in user space coordinates.
	///
	public mutating func addRect(_ rect: Rect) {
		elements.append(.rect(rect))
	}
	
	/// Adds a set of rectangular paths to the current path.
	///
	/// Calling this convenience method is equivalent to repeatedly calling the
	/// ``addRect(_:)`` method for each rectangle in the array.
	///
	/// - Parameter rects: An array of rectangles, specified in user space coordinates.
	///
	public mutating func addRects(_ rects: [Rect]) {
		rects.forEach { rect in
			addRect(rect)
		}
	}
	
	/// Adds a cubic Bézier curve to the current path, with the specified end point and control points.
	///
	/// This method constructs a curve starting from the path's current point
	/// and ending at the specified end point,
	/// with curvature defined by the two control points.
	/// After this method appends that curve to the current path,
	/// the end point of the curve becomes the path's current point.
	///
	/// - Parameters:
	///   - end: The point, in user space coordinates, at which to end the curve.
	///   - control1: The first control point of the curve, in user space coordinates.
	///   - control2: The second control point of the curve, in user space coordinates.
	///
	public mutating func addCurve(to end: Point, control1: Point, control2: Point) {
		elements.append(.curve(to: end, control1: control1, control2: control2))
	}
	
	/// Adds a quadratic Bézier curve to the current path, with the specified end point and control point.
	///
	/// This method constructs a curve starting from the path’s current point
	/// and ending at the specified end point, with curvature defined by the control point.
	/// After this method appends that curve to the current path,
	/// the end point of the curve becomes the path’s current point.
	///
	/// - Parameters:
	///   - end: The point, in user space coordinates, at which to end the curve.
	///   - control: The control point of the curve, in user space coordinates.
	///
	public mutating func addQuadCurve(to end: Point, control: Point) {
		addCurve(to: end, control1: control, control2: control)
	}
	
	/// Adds an ellipse that fits inside the specified rectangle.
	///
	/// The ellipse is approximated by a sequence of Bézier curves.
	/// Its center is the midpoint of the rectangle defined by the rect parameter.
	/// If the rectangle is square, then the ellipse is circular with a radius equal
	/// to one-half the width (or height) of the rectangle.
	/// If the rect parameter specifies a rectangular shape,
	/// then the major and minor axes of the ellipse are defined
	/// by the width and height of the rectangle.
	///
	/// - Parameter rect: A rectangle that defines the area for the ellipse to fit in.
	///
	public mutating func addEllipse(in rect: Rect) {
		elements.append(.ellipse(in: rect))
	}
	
	/// Closes and terminates the current path’s subpath.
	///
	/// Appends a line from the current point to the starting point
	/// of the current subpath and ends the subpath.
	///
	public mutating func closePath() {
		elements.append(.closeSubpath)
	}
}

extension Path {
	var boundingRect: Rect {
		let points = elements.flatMap { element -> [Point] in
			switch element {
			case .move(let point):
				return [point]
				
			case .line(let point):
				return [point]
				
			case .lines(let points):
				return points
				
			case .rect(let rect):
				return [rect.origin, Point(x: rect.maxX, y: rect.maxY)]
				
			case .ellipse(let rect):
				return [rect.origin, Point(x: rect.maxX, y: rect.maxY)]
				
			case .curve(let point, _, _):
				return [point]
				
			case .closeSubpath:
				break
			}
			
			return []
		}
		
		let xPositions = points.map(\.x)
		let yPositions = points.map(\.y)
		
		let minX = xPositions.min() ?? 0
		let maxX = xPositions.max() ?? 0
		
		let minY = yPositions.min() ?? 0
		let maxY = yPositions.max() ?? 0
		
		let origin = Point(x: minX, y: minY)
		
		let width = maxX - minX
		let height = maxY - minY
		
		let size = Size(width: width, height: height)
		
		return Rect(origin: origin, size: size)
	}
}

extension Path: Shape {
	public func path(in rect: Rect) -> Path {
		self
	}
}

extension Path {
	public var body: some View {
		ShapeView(shape: self, style: .fill)
	}
}
