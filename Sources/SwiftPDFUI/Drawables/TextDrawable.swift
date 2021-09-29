struct TextDrawable: Drawable {
	
	var origin: Point = .zero
	
	var size: Size = .zero
	
	var content: String
	
	var modifiers: [Text.Modifier]
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension TextDrawable: CustomStringConvertible {}
