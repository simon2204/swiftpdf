struct ZStackDrawable: Drawable {
	
	var origin: Point = .zero
	
	var size: Size = .zero
	
	var alignment: Alignment
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension ZStackDrawable: CustomStringConvertible {}
