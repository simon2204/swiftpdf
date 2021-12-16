final class SpacerNode: JustifiableNode {
	
	private let minLength: Double
    
    init(minLength: Double?) {
		self.minLength = minLength ?? Default.spacing
		
		super.init()
		
		maxWidth = .infinity
		maxHeight = .infinity
    }
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
        if parent is VStackNode {
            self.height = min(max(minLength, proposedHeight), maxHeight)
        } else if parent is HStackNode {
            self.width = min(max(minLength, proposedWidth), maxWidth)
        }
	}
	
	override func justifyBounds() {
        if parent is VStackNode {
            minHeight = minLength
        } else if parent is HStackNode {
            minWidth = minLength
        }
	}
}
