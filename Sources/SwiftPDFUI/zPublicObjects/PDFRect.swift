/// A structure that contains the location and dimensions of a rectangle.
///
/// The origin is located in the lower-left corner of the rectangle
/// and the rectangle extends towards the upper-right corner.
public struct PDFRect {
    
    /// A point that specifies the coordinates of the rectangle’s origin.
    public var origin: PDFPoint
    
    /// A size that specifies the height and width of the rectangle.
    public var size: PDFSize
    
    /// A point that specifies the coordinates of the rectangle’s center.
    public var center: PDFPoint {
        get {
            PDFPoint(x: midX, y: midY)
        }
        set {
            origin.x = newValue.x - width / 2
            origin.y = newValue.y - height / 2
        }
    }
    
    /// Creates a rectangle with the specified origin and size.
    public init(origin: PDFPoint, size: PDFSize) {
        self.origin = origin
        self.size = size
    }
    
    /// Creates a rectangle with the specified center and size.
    public init(center: PDFPoint, size: PDFSize) {
        self.origin = .zero
        self.size = size
        self.center = center
    }
}

public extension PDFRect {
    /// Creates a rectangle with coordinates and dimensions specified as `Double` values.
    init(x: Double, y: Double, width: Double, height: Double) {
        self.origin = PDFPoint(x: x, y: y)
        self.size = PDFSize(width: width, height: height)
    }
}

public extension PDFRect {
    /// Returns the height of a rectangle.
    var height: Double {
        size.height
    }
    
    /// Returns the width of a rectangle.
    var width: Double {
        size.width
    }
    
    /// Returns the smallest value for the x-coordinate of the rectangle.
    var minX: Double {
        origin.x
    }
    
    /// Returns the x-coordinate that establishes the center of a rectangle.
    var midX: Double {
        (minX + maxX) / 2
    }
    
    /// Returns the largest value of the x-coordinate for the rectangle.
    var maxX: Double {
        minX + width
    }
    
    /// Returns the smallest value for the y-coordinate of the rectangle.
    var minY: Double {
        origin.y
    }
    
    /// Returns the y-coordinate that establishes the center of the rectangle.
    var midY: Double {
        (minY + maxY) / 2
    }
    
    /// Returns the largest value for the y-coordinate of the rectangle.
    var maxY: Double {
        minY + height
    }
}

public extension PDFRect {
    
    /// Returns a rectangle with a positive width and height.
    var standardized: PDFRect {
        let width = size.width.magnitude
        let height = size.height.magnitude
        let size = PDFSize(width: width, height: height)
        return PDFRect(origin: origin, size: size)
    }
    
    /// Returns a rectangle that is smaller or larger than the source rectangle, with the same center point.
    ///
    /// The rectangle is standardized and then the inset parameters are applied.
    ///
    /// - Parameters:
    ///   - dx:
    ///   The x-coordinate value to use for adjusting the source rectangle.
    ///   To create an inset rectangle, specify a positive value.
    ///   To create a larger, encompassing rectangle, specify a negative value.
    ///   - dy:
    ///   The y-coordinate value to use for adjusting the source rectangle.
    ///   To create an inset rectangle, specify a positive value.
    ///   To create a larger, encompassing rectangle, specify a negative value.
    /// - Returns:
    /// A rectangle.
    /// The origin value is offset in the x-axis by the distance specified by the dx parameter
    /// and in the y-axis by the distance specified by the dy parameter,
    /// and its size adjusted by (2*dx,2*dy), relative to the source rectangle.
    /// If dx and dy are positive values, then the rectangle’s size is decreased.
    /// If dx and dy are negative values, the rectangle’s size is increased.
    func insetBy(dx: Double, dy: Double) -> PDFRect {
        var insettedRect = self.standardized
        insettedRect.size.width += 2 * dx
        insettedRect.size.height += 2 * dy
        insettedRect.origin.x -= dx
        insettedRect.origin.y -= dy
        return insettedRect
    }
    
    /// Returns a rectangle with an origin that is offset from that of the source rectangle.
    /// - Parameters:
    ///   - dx: The offset value for the x-coordinate.
    ///   - dy: The offset value for the y-coordinate.
    /// - Returns: A rectangle that is the same size as the source,
    /// but with its origin offset by dx units along the x-axis
    /// and dy units along the y-axis with respect to the source.
    func offsetBy(dx: Double, dy: Double) -> PDFRect {
        var offsettedRect = self
        offsettedRect.origin.x += dx
        offsettedRect.origin.y += dy
        return offsettedRect
    }
}

extension PDFRect: Equatable {}
