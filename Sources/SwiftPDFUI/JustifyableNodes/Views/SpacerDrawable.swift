final class SpacerDrawable: JustifiableNode {
	
	private let minLength: Double
    
    init(minLength: Double?) {
		self.minLength = minLength ?? Default.spacing
		
		super.init()
		
		maxWidth = .infinity
		maxHeight = .infinity
    }
	
    override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		if let stack = parent as? StackNode, let mainAxis = stack.mainAxis {
			if case .horizontal = mainAxis {
				size.width = min(max(minLength, proposedWidth), maxWidth)
			}
		}
    }
    
    override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		if let stack = parent as? StackNode, let mainAxis = stack.mainAxis {
			if case .vertical = mainAxis {
				size.height = min(max(minLength, proposedHeight), maxHeight)
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
