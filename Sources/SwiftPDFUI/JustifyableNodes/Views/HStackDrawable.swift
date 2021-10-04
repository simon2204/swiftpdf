final class HStackDrawable: JustifiableNode {
    
    var alignment: VerticalAlignment
    
    var spacing: Double?
    
    init(alignment: VerticalAlignment, spacing: Double?) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    lazy var spacingRequirement = spacing ?? Default.spacing
	
	lazy var subDrawableCount = Double(children.count)
	
	lazy var totalSpacing: Double = {
		let spacingCount = subDrawableCount - 1
		return  spacingCount * spacingRequirement
	}()
    
    override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		
		// Remaining width after subtracing the total amount of spacing.
        var remainingWidth = proposedWidth - totalSpacing
		
		var childWidth: Double {
			remainingWidth / subDrawableCount
		}
		
		var children = self.children
		
		let pivot = children.partition(by: { $0.minWidth > 0 })
		_ = children[..<pivot].partition(by: { $0.maxWidth < childWidth })
		 
		children.reversed().forEach { child in
			child.justifyWidth(
				proposedWidth: childWidth,
				proposedHeight: proposedHeight)
			subDrawableCount -= 1
			remainingWidth -= child.size.width
		}
		
		size.width = proposedWidth - remainingWidth
    }
    
    override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
        var maxHeight: Double = 0
		children.forEach { child in
            child.justifyHeight(
                proposedWidth: proposedWidth,
                proposedHeight: proposedHeight
            )
			maxHeight = max(maxHeight, child.size.height)
        }
		size.height = maxHeight
    }
    
    override func justify(x: Double) {
		self.origin.x = x
		var xOffSet = x
		children.forEach { child in
            child.justify(x: xOffSet)
			xOffSet += child.size.width + spacingRequirement
        }
    }
	
	override func justify(y: Double) {
		self.origin.y = y
		
		switch alignment {
		case .top:
			alignChildrenAtTop()
		case .center:
			alignChildrenAtCenter()
		case .bottom:
			alignChildrenAtBottom()
		default:
			alignChildrenAtCenter()
		}
	}
	
	func alignChildrenAtTop() {
		children.forEach { child in
			let y = self.size.height - child.size.height
			child.justify(y: y)
		}
	}
	
	func alignChildrenAtCenter() {
		children.forEach { child in
			let y = (self.size.height - child.size.height) / 2
			child.justify(y: y + self.origin.y)
		}
	}
	
	func alignChildrenAtBottom() {
		children.forEach { child in
			child.justify(y: self.origin.y)
		}
	}
	
	override func getBoundary() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		var newBoundary = super.getBoundary()
		newBoundary.minW += totalSpacing
		newBoundary.maxW += totalSpacing
		minWidth = newBoundary.minW
		maxWidth = newBoundary.maxW
		return newBoundary
	}
}
