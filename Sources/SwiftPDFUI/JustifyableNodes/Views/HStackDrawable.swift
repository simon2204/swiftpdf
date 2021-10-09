final class HStackDrawable: StackNode {
    
	/// Vertical alignment of children.
    private var alignment: VerticalAlignment
    
	/// Spacing of children.
    private var spacing: Double?
    
    init(alignment: VerticalAlignment, spacing: Double?) {
        self.alignment = alignment
        self.spacing = spacing
    }
    
	/// Amout of spacing or default spacing, when no spacing has been specified.
	private var appliedSpacing: Double {
		spacing ?? Default.spacing
	}
	
	/// Total amout of spacing needed for spacing all children.
	private var totalSpacing: Double {
		let spacingCount = Double(children.count) - 1
		return spacingCount * appliedSpacing
	}
    
    override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		
		// Count of children which did not justify their width yet.
		var justifiedChildrenWidthCount = Double(children.count)
		
		// Remaining width after subtracing the total amount of spacing.
        var remainingWidth = proposedWidth - totalSpacing
		
		// Compute equal width for all children
		// which did not get a proposal yet.
		var childWidth: Double {
			remainingWidth / justifiedChildrenWidthCount
		}
		
		// Copy of `self.children`, because we want to modify
		// the order of children which get a dimension proposed first.
		var children = self.children
		
		// Least flexible children with a minimum
		// width will get the width dimension proposed first.
		// They will be located in the right half of `children`,
		// starting from the pivot-index.
		let pivot = children.partition(by: { $0.minWidth > 0 })
		
		// Children with a maximum width smaller
		// than the `childWidth`,
		// in the left half of the array before the pivot,
		// will get proposed `childWidth`,
		// so that remaining children can fully use the remaining width.
		_ = children[..<pivot].partition(by: { $0.maxWidth < childWidth })
		 
		// `children` got divided into three partitions.
		// ([child..., (child.maxWidth < childWidth)..., (child.minWidth > 0)...]).
		// Now the order needs to be reversed because we still want
		// children with a minimum width greater than zero to get a proposal first,
		// after that children with a maximum width smaller than `childWidth`
		// and then the remaining children.
		children.reversed().forEach { child in
			child.justifyWidth(
				proposedWidth: childWidth,
				proposedHeight: proposedHeight)
			justifiedChildrenWidthCount -= 1
			remainingWidth -= child.size.width
		}
		
		// Sum of all children's width.
		let childrenWidth = proposedWidth - remainingWidth
		
		size.width = childrenWidth
    }
    
    override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		children.forEach { child in
            child.justifyHeight(
                proposedWidth: proposedWidth,
                proposedHeight: proposedHeight
            )
        }
		size.height = maximumHeightOfChildren
    }
    
    override func justify(x: Double) {
		var xOffSet = x
		children.forEach { child in
            child.justify(x: xOffSet)
			xOffSet += child.size.width + appliedSpacing
        }
		origin.x = x
    }
	
	override func justify(y: Double) {
		switch alignment {
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
		var newBoundary = super.justifyBounds()
		newBoundary.minW += totalSpacing
		newBoundary.maxW += totalSpacing
		minWidth = newBoundary.minW
		maxWidth = newBoundary.maxW
		return newBoundary
	}
}
