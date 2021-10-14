final class VStackDrawable: StackNode {
	
	private let alignment: HorizontalAlignment
	
	private let spacing: Double
	
	init(alignment: HorizontalAlignment, spacing: Double?) {
		self.alignment = alignment
		self.spacing = spacing ?? Default.spacing
		super.init(mainAxis: .vertical)
	}
	
	/// Total amout of spacing needed for spacing all children.
	private var totalSpacing: Double {
		let spacingCount = Double(children.count) - 1
		return spacingCount * spacing
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		// Count of children which did not justify their height yet.
		var justifiedChildrenHeightCount = Double(children.count)

		// Remaining height after subtracing the total amount of spacing.
		var remainingHeight = proposedHeight - totalSpacing

		// Compute equal height for all children
		// which did not get a proposal yet.
		var childHeight: Double {
			remainingHeight / justifiedChildrenHeightCount
		}

		// Copy of `self.children`, because we want to modify
		// the order of children which get a dimension proposed first.
		var stackElements = self.children

		// Seperates spacers from all other children.
		let p0 = stackElements.partition(by: { $0 is SpacerDrawable })

		// Least flexible children with a minimum
		// height will get the height dimension proposed first.
		// They will be located in the right half of `children`,
		// starting from the pivot-index.
		let p1 = stackElements[..<p0].partition(by: { $0.minHeight > 0 })

		// Children with a maximum height smaller
		// than the `childHeight`,
		// in the left half of the array before the pivot,
		// will get proposed `childHeight`,
		// so that remaining children can fully use the remaining height.
		let p2 = stackElements[..<p1].partition(by: { $0.maxHeight < childHeight })
		
		// [(child.minHeight > 0)...,
		//  (child.maxHeight < childHeight)...,
		//  (remaining children not including spacers)...]
		var children = stackElements[p1..<p0] + stackElements[p2..<p1] + stackElements[..<p2]

		// Subsequence containing only spacers.
		let spacers = stackElements[p0...]

		// Indicates whether there are children left
		// that want to claim the entire available space.
		let needsToLayoutChildrenWithFlexibleHeight = p2 > 0

		// If there are children in the stack who want to
		// take the entire remaining height that they are given to..
		if needsToLayoutChildrenWithFlexibleHeight {
			for spacer in spacers {
				// ..spacers shall only take their minimum height from the remaining height.
				spacer.maxWidth = spacer.minWidth
				spacer.maxHeight = spacer.minHeight
			}
			// Spacers with a fixed height will take their
			// needed space from the remaining available space first.
			children = spacers + children
		} else {
			// Spacers will take up the remaining available space,
			// after all other children have claimed their space
			children = children + spacers
		}
		
		// Width of the widest child.
		var maximumWidthOfChildren: Double = 0
		
		for child in children {
			
			child.justify(proposedWidth: proposedWidth, proposedHeight: childHeight)
			
			justifiedChildrenHeightCount -= 1
			
			remainingHeight -= child.height
			
			// Calculate the height of the tallest child.
			maximumWidthOfChildren = max(maximumWidthOfChildren, child.width)
		}

		self.width = maximumWidthOfChildren
		
		// Sum of all children's height.
		self.height = proposedHeight - remainingHeight
	}
	
	
	
	override func justify(x: Double) {
		self.x = x
		switch alignment {
		case .leading:
			alignChildrenLeading()
		case .center:
			centerChildrenHorizontally()
		case .trailing:
			alignChildrenTrailing()
		}
	}
	
	override func justify(y: Double) {
		self.y = x
	
		var offsetY = y
		
		for child in children.reversed() {
			child.justify(y: offsetY)
			offsetY += child.height + spacing
		}
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		var newBoundary = super.justifyBounds()
		newBoundary.minH += totalSpacing
		newBoundary.maxH += totalSpacing
		minHeight = newBoundary.minH
		maxHeight = newBoundary.maxH
		return newBoundary
	}
}
