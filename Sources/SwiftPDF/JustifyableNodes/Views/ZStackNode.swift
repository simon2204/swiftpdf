final class ZStackNode: AlignmentNode {
	
	private var alignment: Alignment
	
	init(alignment: Alignment) {
		self.alignment = alignment
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		var maximumWidthOfChildren: Double = 0
		var maximumHeightOfChildren: Double = 0
        
		for child in children {
			child.justify(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
			maximumWidthOfChildren = max(maximumWidthOfChildren, child.width)
			maximumHeightOfChildren = max(maximumHeightOfChildren, child.height)
		}
		
		self.width = maximumWidthOfChildren
		self.height = maximumHeightOfChildren
	}
	
	override func justify(x: Double) {
		self.x = x
		
		switch alignment.horizontal {
		case .leading:
			alignChildrenLeading()
			
		case .center:
			centerChildrenHorizontally()
			
		case .trailing:
			alignChildrenTrailing()
		}
	}
	
	override func justify(y: Double) {
		self.y = y
		
		switch alignment.vertical {
		case .top:
			alignChildrenTop()
			
		case .center:
			centerChildrenVertically()
			
		case .bottom:
			alignChildrenBottom()
		}
	}
	
	override func justifyBounds() {
		for child in children {
			child.justifyBounds()
			minWidth = max(minWidth, child.minWidth)
			minHeight = max(minHeight, child.minHeight)
			maxWidth = max(maxWidth, child.maxWidth)
			maxHeight = max(maxHeight, child.maxHeight)
		}
	}
}
