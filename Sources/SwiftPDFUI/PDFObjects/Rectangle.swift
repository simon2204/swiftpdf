/// Rectangles are used to describe locations on a page and bounding boxes
///
/// Rectangles are used to describe locations on a page and bounding boxes for a variety of objects.
/// A rectangle shall be written as an array of four numbers giving the
/// coordinates of a pair of diagonally opposite corners.
struct Rectangle {
    
    /// Origin's x coordinate.
    var x: Double = 0
    
    /// Origin's y coordinate.
    var y: Double = 0
    
    /// Width value
    let width: Double
    
    /// Height value
    let height: Double
    
    private var lowerLeftX: Double {
        return x
    }
    
    private var lowerLeftY: Double {
        return y
    }
    
    private var upperRightX: Double {
        return x + width
    }
    
    private var upperRightY: Double {
        return y + height
    }
}

extension Rectangle: ExpressibleAsPDFArray {
	var pdfArray: [Double] {
		[lowerLeftX, lowerLeftY,
		 upperRightX, upperRightY]
	}
}
