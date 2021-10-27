final class VStackDrawable: StackNode {
	
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
		
		var partitionedChildren = self.children
		
		let p0 = partitionedChildren.partition(by: { $0.minHeight > 0 })
		
		let minChildrenCount = partitionedChildren[..<p0].count
		
		let minSum = partitionedChildren[p0...].map(\.minHeight).reduce(0, +)
		
		var remainingHeight = proposedHeight - totalSpacing - minSum
		
		let minChildHeight = remainingHeight / Double(minChildrenCount)
		
		let _ = partitionedChildren[..<p0].partition(by: { $0.maxHeight <= minChildHeight })
		
		remainingHeight = justify(
			children: partitionedChildren[..<p0],
			totalHeight: remainingHeight,
			proposedWidth: proposedWidth
		)
		
		let p3 = partitionedChildren[p0...].partition(by: { $0.maxHeight < .infinity })
		
		partitionedChildren[p0..<p3].sort(by: { $0.minHeight < $1.minHeight })
		
		remainingHeight = justify(
			children: partitionedChildren[p0...],
			totalHeight: remainingHeight + minSum,
			proposedWidth: proposedWidth
		)
		
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
