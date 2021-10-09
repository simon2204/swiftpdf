final class ZStackDrawable: StackNode {
	
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
		size.width = maximumWidthOfChildren
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		for child in children {
			child.justifyHeight(
				proposedWidth: proposedWidth,
				proposedHeight: proposedHeight
			)
		}
		size.height = maximumHeightOfChildren
	}
	
	override func justify(x: Double) {
		switch alignment.horizontal {
		case .leading:
			alignChildrenLeading()
			
		case .center:
			centerChildrenHorizontally()
			
		case .trailing:
			alignChildrenTrailing()
		}
		
		origin.x = x
	}
	
	override func justify(y: Double) {
		switch alignment.vertical {
		case .top:
			alignChildrenTop()
		case .center:
			centerChildrenVertically()
		case .bottom:
			alignChildrenBottom()
		default:
			centerChildrenVertically()
		}
		
		origin.y = y
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		for child in children {
			let bounds = child.justifyBounds()
			minWidth = min(minWidth, bounds.minW)
			minHeight = min(minHeight, bounds.minH)
			maxWidth = max(maxWidth, bounds.maxW)
			maxHeight = max(maxHeight, bounds.maxH)
		}
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
}
