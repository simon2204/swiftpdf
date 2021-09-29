struct VStackDrawable: Drawable {
	
	var origin: Point = .zero
	
	var size: Size = .zero
	
	var alignment: HorizontalAlignment
	
	var spacing: Double?
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension VStackDrawable: CustomStringConvertible {}
