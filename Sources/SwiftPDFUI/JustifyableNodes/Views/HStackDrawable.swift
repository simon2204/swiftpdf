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
    
    override func justifyWidth(proposedWidth: Double, proposedHeight: Double) -> Double {
        var subDrawableCount = Double(children?.count ?? 0)
        let spacingCount = Double(subDrawableCount - 1)
        let currentSpacing = spacing ?? Default.spacing
        let totalSpacing = spacingCount * currentSpacing
        var remainingWidth = proposedWidth - totalSpacing
        
        var childWidth: Double {
            remainingWidth / subDrawableCount
        }
        
        children?.forEach { child in
            let wantedWidth = child.justifyWidth(
                proposedWidth: childWidth,
                proposedHeight: proposedHeight
            )
            remainingWidth -= wantedWidth
            subDrawableCount -= 1
        }
		
		size.width = proposedWidth - remainingWidth
        
		return size.width
    }
    
    override func justifyHeight(proposedWidth: Double, proposedHeight: Double) -> Double {
        var maxHeight: Double = 0
        
        children?.forEach { child in
            let wantedHeight = child.justifyHeight(
                proposedWidth: proposedWidth,
                proposedHeight: proposedHeight
            )
            maxHeight = max(maxHeight, wantedHeight)
        }
		
		size.height = maxHeight
        
        return maxHeight
    }
    
    override func justify(x: Double) {
		self.origin.x = x
		var xOffSet = x
		
        children?.forEach { child in
            child.justify(x: xOffSet)
			xOffSet += child.size.width + spacingRequirement
        }
    }
}
