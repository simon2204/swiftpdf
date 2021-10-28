final class VStackDrawable: StackNode {
	
	private typealias Partition = Array<JustifiableNode>.SubSequence
	
	private let alignment: HorizontalAlignment
	
	private let spacing: Double
	
	init(alignment: HorizontalAlignment, spacing: Double?) {
		self.alignment = alignment
		self.spacing = spacing ?? Default.spacing
		super.init(mainAxis: .vertical)
	}
	
	/// Total amout of spacing needed for spacing all children.
	var totalSpacing: Double {
		let spacingCount = Double(children.count) - 1
		return spacingCount * spacing
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		
		// Copy of children, because we don't want to modify the actual order of children.
		var childrenCopy = self.children
		
		// `childrenCopy` contains only SpacerDrawables starting from this index.
		let spacerPivot = childrenCopy.partition(by: { $0 is SpacerDrawable })
		
		let spacers = childrenCopy[spacerPivot...]
		
		var remainingViews = childrenCopy[..<spacerPivot]
		
		let reservedMinimumSpaceForSpacers = spacers.lazy.map(\.minHeight).reduce(0, +)
		
		var remainingHeight = proposedHeight - totalSpacing - reservedMinimumSpaceForSpacers
		
		var remainingViewCount = remainingViews.count
		
		var equalChildHeight: Double {
			remainingHeight / Double(remainingViewCount)
		}
		
		func justViews(inPartition partition: Partition, proposedLength: (JustifiableNode) -> Double) {
			for view in partition {
				let proposedLength = proposedLength(view)
				view.justify(proposedWidth: proposedWidth, proposedHeight: proposedLength)
				remainingHeight -= view.height
				remainingViewCount -= 1
			}
		}
		
		func justifyViewsWithMinimumSpace() {
			var viewsGreaterThanEqualChildHeight: Partition
			
			repeat {
				
				let p = remainingViews.partition(by: { $0.minHeight >= equalChildHeight })
				
				viewsGreaterThanEqualChildHeight = remainingViews[p...]
				
				remainingViews = remainingViews[..<p]
				
				justViews(inPartition: viewsGreaterThanEqualChildHeight) { view in
					view.minHeight
				}
				
			} while !viewsGreaterThanEqualChildHeight.isEmpty
		}
		
		justifyViewsWithMinimumSpace()
		
		let p = remainingViews.partition(by: { $0.maxHeight < equalChildHeight })
		
		let viewsSmallerThanEqualChildWidth = remainingViews[p...]
		
		remainingViews = remainingViews[..<p]
		
		for view in viewsSmallerThanEqualChildWidth {
			view.justify(proposedWidth: proposedWidth, proposedHeight: equalChildHeight)
			remainingHeight -= view.height
			remainingViewCount -= 1
		}
		
		justViews(inPartition: remainingViews) { _ in
			equalChildHeight
		}
		
		remainingHeight += reservedMinimumSpaceForSpacers
		
		remainingViews = spacers
		remainingViewCount = spacers.count
		
		justifyViewsWithMinimumSpace()
		
		justViews(inPartition: remainingViews) { _ in
			equalChildHeight
		}
		
		self.width = children.lazy.max(by: { $0.width < $1.width })?.width ?? 0
		self.height = children.lazy.map(\.height).reduce(0, +) + totalSpacing
	}
	
	
	private func justify(children: Array<JustifiableNode>.SubSequence, totalHeight: Double, proposedWidth: Double) -> Double {
		
		var remainingChildren = children.count
		
		var remainingHeight = totalHeight
		
		var childHeight: Double {
			remainingHeight / Double(remainingChildren)
		}
		
		for child in children.reversed() {
			child.justify(proposedWidth: proposedWidth, proposedHeight: childHeight)
			remainingChildren -= 1
			remainingHeight -= child.height
		}
		
		return remainingHeight
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
