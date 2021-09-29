final class TextDrawable: Drawable, NodeProtocol {
	
	var origin: Point = .zero
	
	var size: Size = .zero
    
    var children: [NodeProtocol]?
	
	var content: String
	
	var modifiers: [Text.Modifier]
    
    init(content: String, modifiers: [Text.Modifier]) {
        self.content = content
        self.modifiers = modifiers
    }
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
    
    
}

extension TextDrawable: CustomStringConvertible {}
