struct TupleDrawable: Drawable {
	var origin: Point = .zero
	
	var size: Size = .zero
	
	func getWidthForProposedWidth(_ width: Double) -> Double {
		width
	}
	
	func getHeightForProposedHeight(_ height: Double) -> Double {
		height
	}
}

extension TupleDrawable: CustomStringConvertible {}
