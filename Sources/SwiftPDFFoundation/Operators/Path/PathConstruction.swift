/// Path construction operators define the geometry of a path.
///
/// A path description is built up through the invocation of one or more path construction operators
/// that add segments to it.
/// The path construction operators may be invoked in any sequence,
/// but the first one invoked shall be `Operator.PathConstruction.move(x:y:)` or
/// `Operator.PathConstruction.rectangle(x:y:width:height:)` to begin a new subpath.
/// The path definition may conclude with the application of a path-painting operator such as
/// `Operator.PathPainting.stroke`, `Operator.PathPainting.fill`, or
/// `Operator.PathPainting.closeFillAndStroke`;
/// this operator may optionally be preceded by one of the clipping path operators
/// `Operator.PathClipping.winding` or
/// `Operator.PathClipping.evenOdd`.
enum PathConstruction {
    /// Begin a new subpath by moving the current point to coordinates (x, y).
    ///
    /// Omitting any connecting line segment.
    /// If the previous path construction operator in the current path was also m,
    /// the new m overrides it; no vestige of the previous m operation remains in the path.
    ///
    ///  - Parameters:
    ///    - x: X-coordinate to move the current point to.
    ///    - y: Y-coordinate to move the current point to.
    case move(x: Double, y: Double)
    
    /// Append a straight line segment from the current point to the point (x, y).
    ///
    /// The new current point shall be (x, y).
    ///
    /// - Parameters:
    ///   - x: X-coordinate of the line's end and new current point.
    ///   - y: Y-coordinate of the line's end and new current point.
    case line(x: Double, y: Double)
    
    /// Append a cubic Bézier curve to the current path.
    ///
    /// The curve shall extend from the current point to the point (x3, y3),
    /// using (x1, y1) and (x2, y2) as the Bézier control points.
    ///
    /// The new current point shall be (x3, y3).
    ///
    /// - Parameters:
    ///   - x1: X-coordinate of the first control point.
    ///   - y1: Y-coordinate of the first control point.
    ///   - x2: X-coordinate of the second control point.
    ///   - y2: Y-coordinate of the second control point.
    ///   - x3: X-coordinate of the curves's end and new current point.
    ///   - y3: Y-coordinate of the curves's end and new current point.
    case cubic1(x1: Double, y1: Double, x2: Double,
				y2: Double, x3: Double, y3: Double)
    
    /// Append a cubic Bézier curve to the current path.
    ///
    /// The curve shall extend from the current point to the point (x3, y3),
    /// using the current point and (x2, y2) as the Bézier control points.
    ///
    /// The new current point shall be (x3, y3).
    ///
    /// - Parameters:
    ///   - x2: X-coordinate of the second control point.
    ///   - y2: Y-coordinate of the second control point.
    ///   - x3: X-coordinate of the curves's end and new current point.
    ///   - y3: Y-coordinate of the curves's end and new current point.
    case cubic2(x2: Double, y2: Double, x3: Double, y3: Double)
    
    /// Append a cubic Bézier curve to the current path.
    ///
    /// The curve shall extend from the current point to the point (x3, y3),
    /// using (x1, y1) and (x3, y3) as the Bézier control points.
    ///
    /// The new current point shall be (x3, y3).
    ///
    /// - Parameters:
    ///   - x1: X-coordinate of the first control point.
    ///   - y1: Y-coordinate of the first control point.
    ///   - x3: X-coordinate of the curves's end and new current point.
    ///   - y3: Y-coordinate of the curves's end and new current point.
    case cubic3(x1: Double, y1: Double, x3: Double, y3: Double)
    
    /// Close the current subpath.
    ///
    /// Close the current subpath by appending a straight line segment
    /// from the current point to the starting point of the subpath.
    /// If the current subpath is already closed, `close` shall do nothing.
    /// This operator terminates the current subpath.
    /// Appending another segment to the current path shall begin a new subpath,
    /// even if the new segment begins at the endpoint reached by the `close` operation.
    case close
    
    /// Append a rectangle to the current path.
    ///
    /// Append a rectangle to the current path as a complete subpath,
    /// with lower-left corner (x, y) and dimensions width and height in user space.
    ///
    /// - Parameters:
    ///   - x: X-coordinate to move the lower-left corner point to.
    ///   - y: Y-coordinate to move the lower-left corner point to.
    ///   - width: The rectangle's width dimension.
    ///   - height: The rectangle's height dimension.
    case rectangle(x: Double, y: Double, width: Double, height: Double)
}

extension PathConstruction: ExpressibleAsPDFString {
    var pdfString: String {
        switch self {
        case let .move(x, y):
            return "\(x) \(y) m"
            
        case let .line(x, y):
            return "\(x) \(y) l"
            
        case let .cubic1(x1, y1, x2, y2, x3, y3):
            return "\(x1) \(y1) \(x2) \(y2) \(x3) \(y3) c"
            
        case let .cubic2(x2, y2, x3, y3):
            return "\(x2) \(y2) \(x3) \(y3) v"
            
        case let .cubic3(x1, y1, x3, y3):
            return "\(x1) \(y1) \(x3) \(y3) y"
            
        case .close:
            return "h"
            
        case let .rectangle(x, y, width, height):
            return "\(x) \(y) \(width) \(height) re"
        }
    }
}
