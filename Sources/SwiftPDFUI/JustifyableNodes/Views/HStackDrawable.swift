final class HStackDrawable: StackNode {
    
	/// Vertical alignment of children.
    private let alignment: VerticalAlignment
    
	/// Spacing between children.
    private let spacing: Double
    
    init(alignment: VerticalAlignment, spacing: Double?) {
        self.alignment = alignment
		self.spacing = spacing ?? Default.spacing
		super.init(mainAxis: .horizontal)
    }
	
	/// Total amout of spacing needed for spacing all children.
	private var totalSpacing: Double {
		// Count of spacings needed to have one spacing beween each child.
		let spacingCount = Double(children.count) - 1
		
		return spacingCount * spacing
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		
		// Count of children which did not justify their width yet.
		var countOfNotJustifiedChildren = Double(children.count)
		
		// Remaining width after subtracing the total amount of spacing.
		var remainingWidth = proposedWidth - totalSpacing
		
		// Compute equal width for all children
		// which did not get a proposal yet.
		var childWidth: Double {
			remainingWidth / countOfNotJustifiedChildren
		}
		
		// Copy of `self.children`, because we want to modify
		// the order of children which get a dimension proposed first
		// but not the original order.
		var stackElements = self.children
		
		// Seperates spacers from all other children.
		let p0 = stackElements.partition(by: { $0 is SpacerDrawable })
		
		// Least flexible children with a minimum
		// width will get the width dimension proposed first.
		// They will be located in the right half of `children`,
		// starting from the pivot-index.
		let p1 = stackElements[..<p0].partition(by: { $0.minWidth > 0 })
		
		// Children with a maximum width smaller
		// than the `childWidth`,
		// in the left half of the array before the pivot,
		// will get proposed `childWidth`,
		// so that remaining children can fully use the remaining width.
		let p2 = stackElements[..<p1].partition(by: { $0.maxWidth < childWidth })
		
		// [(child.minWidth > 0)...,
		//  (child.maxWidth < childWidth)...,
		//  (remaining children not including spacers)...]
		var children = stackElements[p1..<p0] + stackElements[p2..<p1] + stackElements[..<p2]
		
		// Subsequence which contains only spacers.
		let spacers = stackElements[p0...]
		
		// Indicates whether there are children left
		// that want to claim the entire available space.
		let needsToLayoutChildrenWithFlexibleWidth = p2 > 0
		
		// If there are children in the stack who want to
		// take the entire remaining width that they are given to..
		if needsToLayoutChildrenWithFlexibleWidth {
			for spacer in spacers {
				// ..spacers shall only take their minimum width from the remaining width.
				spacer.maxWidth = spacer.minWidth
				spacer.maxHeight = spacer.minHeight
			}
			// Spacers with a fixed width will take their
			// needed space from the remaining available space first.
			children = spacers + children
		} else {
			// Spacers will take up the remaining available space,
			// after all other children have claimed their space.
			children = children + spacers
		}
		
		// Height of the tallest child.
		var maximumHeightOfChildren: Double = 0
		
		for child in children {
			// Justify each children with the calculated `childWidth`.
			child.justify(proposedWidth: childWidth, proposedHeight: proposedHeight)
			
			// Decrease count of children that need to be justified.
			countOfNotJustifiedChildren -= 1
			
			// Remove the width from the `remainingWidth` which a child just took.
			remainingWidth -= child.width
			
			// Calculate the height of the tallest child.
			maximumHeightOfChildren = max(maximumHeightOfChildren, child.height)
		}
		
		// Sum of all children's width plus total amount of spacing.
		self.width = proposedWidth - remainingWidth
		
		// The `HStack` inherits the height of the tallest child.
		self.height = maximumHeightOfChildren
	}
	
	override func justify(x: Double) {
		self.x = x
		
		var offsetX = x
		
		for child in children {
			child.justify(x: offsetX)
			offsetX += child.width + spacing
		}
	}
	
	override func justify(y: Double) {
		self.y = y
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
