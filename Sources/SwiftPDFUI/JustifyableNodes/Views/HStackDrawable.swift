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
		
		var partitionedChildren = self.children
		
		let p0 = partitionedChildren.partition(by: { $0.minWidth > 0 })
		
		let minChildrenCount = partitionedChildren[..<p0].count
		
		let minSum = partitionedChildren[p0...].map(\.minWidth).reduce(0, +)
		
		var remainingWidth = proposedWidth - totalSpacing - minSum
		
		let minChildWidth = remainingWidth / Double(minChildrenCount)
		
		let _ = partitionedChildren[..<p0].partition(by: { $0.maxWidth <= minChildWidth })
		
		remainingWidth = justify(
			children: partitionedChildren[..<p0],
			totalWidth: remainingWidth,
			proposedHeight: proposedHeight
		)
		
		let p3 = partitionedChildren[p0...].partition(by: { $0.maxWidth < .infinity })
		
		//partitionedChildren[p3...].sort(by: { $0.minWidth < $1.minWidth })
		
		partitionedChildren[p0..<p3].sort(by: { $0.minWidth < $1.minWidth })
		
		remainingWidth = justify(
			children: partitionedChildren[p0...],
			totalWidth: remainingWidth + minSum,
			proposedHeight: proposedHeight
		)
		
		self.width = children.lazy.map(\.width).reduce(0, +) + totalSpacing
		self.height = children.lazy.max(by: { $0.height < $1.height })?.height ?? 0
	}
	
	
	private func justify(children: Array<JustifiableNode>.SubSequence, totalWidth: Double, proposedHeight: Double) -> Double {
		
		var remainingChildren = children.count
		
		var remainingWidth = totalWidth
		
		var childWidth: Double {
			remainingWidth / Double(remainingChildren)
		}
		
		for child in children.reversed() {
			child.justify(proposedWidth: childWidth, proposedHeight: proposedHeight)
			remainingChildren -= 1
			remainingWidth -= child.width
		}
		
		return remainingWidth
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
