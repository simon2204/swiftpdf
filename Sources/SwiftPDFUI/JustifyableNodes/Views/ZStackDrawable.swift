final class ZStackDrawable: JustifiableNode {
	
	/// Vertical alignment of children.
	private var alignment: Alignment
	
	init(alignment: Alignment) {
		self.alignment = alignment
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		for child in children {
			child.justifyWidth(
				proposedWidth: proposedWidth,
				proposedHeight: proposedHeight
			)
		}
		
		// If there is no child and therefore no maximum, zero will be returned.
		let maximumWidthOfChildren = children.lazy.map(\.size.width).max() ?? 0
		
		size.width = maximumWidthOfChildren
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		for child in children {
			child.justifyHeight(
				proposedWidth: proposedWidth,
				proposedHeight: proposedHeight
			)
		}
		
		// If there is no child and therefore no maximum, zero will be returned.
		let maximumHeightOfChildren = children.lazy.map(\.size.height).max() ?? 0
		
		size.height = maximumHeightOfChildren
	}
	
	override func justify(x: Double) {
		for child in children {
			child.justify(x: x)
		}
		origin.x = x
	}
	
	override func justify(y: Double) {
		for child in children {
			child.justify(y: y)
		}
		origin.y = y
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		super.justifyBounds()
	}
}
