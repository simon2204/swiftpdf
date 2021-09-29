final class TupleDrawable: Drawable, NodeProtocol {
    
	var origin: Point = .zero
	
	var size: Size = .zero
    
    var children: [NodeProtocol]?
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
    
    
}

extension TupleDrawable: CustomStringConvertible {}
