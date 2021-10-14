final class SpacerDrawable: JustifiableNode {
	
	private let minLength: Double
    
    init(minLength: Double?) {
		self.minLength = minLength ?? Default.spacing
		
		super.init()
		
		maxWidth = .infinity
		maxHeight = .infinity
    }
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let stack = parent as? StackNode, let mainAxis = stack.mainAxis {
			switch mainAxis {
			case .vertical:
				self.height = min(max(minLength, proposedHeight), maxHeight)
			case .horizontal:
				self.width = min(max(minLength, proposedWidth), maxWidth)
			}
		}
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		if let stack = parent as? StackNode, let mainAxis = stack.mainAxis {
			switch mainAxis {
			case .vertical:
				minHeight = minLength
			case .horizontal:
				minWidth = minLength
			}
		}
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
}
