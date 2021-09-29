struct SpacerDrawable: Drawable {
	
	var origin: Point = .zero
	
	var size: Size = .zero
	
	var minLength: Double?
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension SpacerDrawable: CustomStringConvertible {}
