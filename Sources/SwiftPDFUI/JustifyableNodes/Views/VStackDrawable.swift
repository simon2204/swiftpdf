final class VStackDrawable: StackNode {
	
	let alignment: HorizontalAlignment
	
	let spacing: Double
	
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
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		for child in children {
			child.justifyWidth(
				proposedWidth: proposedWidth,
				proposedHeight: proposedHeight
			)
		}
		size.width = maximumWidthOfChildren
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {

		// Count of children which did not justify their width yet.
		var justifiedChildrenHeightCount = Double(children.count)

		// Remaining width after subtracing the total amount of spacing.
		var remainingHeight = proposedHeight - totalSpacing

		// Compute equal width for all children
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
		// width will get the width dimension proposed first.
		// They will be located in the right half of `children`,
		// starting from the pivot-index.
		let p1 = stackElements[..<p0].partition(by: { $0.minHeight > 0 })

		// Children with a maximum width smaller
		// than the `childWidth`,
		// in the left half of the array before the pivot,
		// will get proposed `childWidth`,
		// so that remaining children can fully use the remaining width.
		let p2 = stackElements[..<p1].partition(by: { $0.maxHeight < childHeight })
		
		// [(child.minWidth > 0)..., (child.maxWidth < childWidth)..., (remaining children not including spacers)...]
		var children = stackElements[p1..<p0] + stackElements[p2..<p1] + stackElements[..<p2]

		// Subsequence containing only spacers.
		let spacers = stackElements[p0...]

		// Indicates whether there are children left
		// that want to claim the entire available space.
		let needsToLayoutChildrenWithFlexibleHeight = p2 > 0

		// If there are children in the stack who want to
		// take the entire remaining width that they are given to..
		if needsToLayoutChildrenWithFlexibleHeight {
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
			// after all other children have claimed their space
			children = children + spacers
		}

		// `children` got divided into three partitions.
		// ([child..., (child.maxWidth < childWidth)..., (child.minWidth > 0)...]).
		// Now the order needs to be reversed because we still want
		// children with a minimum width greater than zero to get a proposal first,
		// after that children with a maximum width smaller than `childWidth`
		// and then the remaining children.
		for child in children {
			child.justifyHeight(
				proposedWidth: proposedWidth,
				proposedHeight: childHeight)
			justifiedChildrenHeightCount -= 1
			remainingHeight -= child.size.height
		}

		// Sum of all children's height.
		let childrenHeight = proposedHeight - remainingHeight

		size.height = childrenHeight
	}

	
	override func justify(x: Double) {
		self.origin.x = x
		
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
		self.origin.y = y
		var yOffSet = y
		children.reversed().forEach { child in
			child.justify(y: yOffSet)
			yOffSet += child.size.height + spacing
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
