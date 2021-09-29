final class VStackDrawable: Drawable, NodeProtocol {
	
    var origin: Point = .zero
    
    var size: Size = .zero
    
    var children: [NodeProtocol]?
    
    var alignment: HorizontalAlignment
    
    var spacing: Double?
    
    init(alignment: HorizontalAlignment, spacing: Double?) {
        self.alignment = alignment
        self.spacing = spacing
    }
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension VStackDrawable: CustomStringConvertible {}
