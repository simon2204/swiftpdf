import Foundation

/// Rectangles are used to describe locations on a page and bounding boxes
///
/// Rectangles are used to describe locations on a page and bounding boxes for a variety of objects.
/// A rectangle shall be written as an array of four numbers giving the coordinates of a pair of diagonally opposite corners.
struct Rectangle: PDFObject {
    var x: Double = 0
    var y: Double = 0
    
    let width: Double
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

    var pdfData: Data {
        [lowerLeftX, lowerLeftY,
         upperRightX, upperRightY].pdfData
    }
}
