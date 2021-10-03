final class HStackDrawable: JustifiableNode {
    
    var alignment: VerticalAlignment
    
    var spacing: Double?
    
    init(alignment: VerticalAlignment, spacing: Double?) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
    var spacingRequirement: Double {
        spacing ?? Default.spacing
    }
    
    override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		
		var subDrawableCount = Double(children.count)
		
		let spacingCount = subDrawableCount - 1
		
		let totalSpacing = spacingCount * spacingRequirement
		
		// Remaining width after subtracing the total amount of spacing.
        var remainingWidth = proposedWidth - totalSpacing
		
		var childWidth: Double {
			remainingWidth / subDrawableCount
		}
		
		var children = [JustifiableNode]()
		children.reserveCapacity(self.children.count)
		
		children += self.children.lazy.filter { $0.boundary.minWidth != nil && $0.boundary.maxWidth != nil }
		children += self.children.lazy.filter { $0.boundary.maxWidth ?? .infinity < childWidth && $0.boundary.minWidth == nil }
		children += self.children.lazy.filter { $0.boundary.maxWidth ?? .infinity > childWidth && $0.boundary.minWidth == nil }
		
		assert(
			children.count == self.children.count,
			"Filtered children of count \(children.count) does not equal \(self.children.count)"
		)
		
		children.forEach { child in
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
}
