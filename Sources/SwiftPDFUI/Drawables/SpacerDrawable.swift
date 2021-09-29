final class SpacerDrawable: Drawable, NodeProtocol {
	
	var origin: Point = .zero
	
	var size: Size = .zero
    
    var children: [NodeProtocol]?
	
	var minLength: Double?
    
    init(minLength: Double?) {
        self.minLength = minLength
    }
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension SpacerDrawable: CustomStringConvertible {}
