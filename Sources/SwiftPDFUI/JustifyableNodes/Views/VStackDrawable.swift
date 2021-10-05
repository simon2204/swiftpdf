final class VStackDrawable: JustifiableNode {
	
	var alignment: HorizontalAlignment
	
	var spacing: Double?
	
	init(alignment: HorizontalAlignment, spacing: Double?) {
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
		var maxWidth: Double = 0
		children.forEach { child in
			child.justifyWidth(
				proposedWidth: proposedWidth,
				proposedHeight: proposedHeight
			)
			maxWidth = max(maxWidth, child.size.width)
		}
		size.width = maxWidth
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		// Remaining width after subtracing the total amount of spacing.
		var remainingHeight = proposedHeight - totalSpacing

		var childHeight: Double {
			remainingHeight / subDrawableCount
		}

		var children = self.children

		let pivot = children.partition(by: { $0.minHeight > 0 })
		_ = children[..<pivot].partition(by: { $0.maxHeight < childHeight })

		children.reversed().forEach { child in
			child.justifyHeight(
				proposedWidth: proposedWidth,
				proposedHeight: childHeight)
			subDrawableCount -= 1
			remainingHeight -= child.size.height
		}

		size.height = proposedHeight - remainingHeight
	}
	
	override func justify(x: Double) {
		self.origin.x = x
		
		switch alignment {
		case .leading:
			alignChildrenLeading()
		case .center:
			alignChildrenCenter()
		case .trailing:
			alignChildrenTrailing()
		}
	}
	
	override func justify(y: Double) {
		self.origin.y = y
		var yOffSet = y
		children.reversed().forEach { child in
			child.justify(y: yOffSet)
			yOffSet += child.size.height + spacingRequirement
		}
	}
	
	func alignChildrenLeading() {
		children.forEach { child in
			child.justify(x: self.origin.x)
		}
	}
	
	func alignChildrenCenter() {
		children.forEach { child in
			let x = (self.size.width - child.size.width) / 2
			child.justify(x: x + self.origin.x)
		}
	}
	
	func alignChildrenTrailing() {
		children.forEach { child in
			let x = self.size.width - child.size.width
			child.justify(x: x)
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
