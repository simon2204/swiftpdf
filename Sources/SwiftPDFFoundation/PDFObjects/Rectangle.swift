/// Rectangles are used to describe locations on a page and bounding boxes.
///
/// Rectangles are used to describe locations on a page and bounding boxes for a variety of objects.
/// A rectangle shall be written as an array of four numbers giving the
/// coordinates of a pair of diagonally opposite corners.
struct Rectangle {
    var lowerLeftX: Double
	var lowerLeftY: Double
    var upperRightX: Double
    var upperRightY: Double
}

extension Rectangle: ExpressibleAsPDFArray {
	var pdfArray: [Double] {
		[lowerLeftX, lowerLeftY,
		 upperRightX, upperRightY]
	}
}
