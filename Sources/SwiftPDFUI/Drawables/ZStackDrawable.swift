final class ZStackDrawable: Drawable, NodeProtocol {
	
    var origin: Point = .zero
    
    var size: Size = .zero
    
    var children: [NodeProtocol]?
    
	var alignment: Alignment
    
    init(alignment: Alignment) {
        self.alignment = alignment
    }
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
    
    
}

extension ZStackDrawable: CustomStringConvertible {}
