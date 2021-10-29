final class HStackDrawable: StackNode {
	
	private typealias Partition = Array<JustifiableNode>.SubSequence
    
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
		
		// Copy of children, because we don't want to modify the actual order of children.
		var childrenCopy = self.children
		
		// `childrenCopy` contains only SpacerDrawables starting from this index.
		let spacerPivot = childrenCopy.partition(by: { $0 is SpacerDrawable })
		
		let spacers = childrenCopy[spacerPivot...]
		
		var remainingViews = childrenCopy[..<spacerPivot]
		
		let reservedMinimumSpaceForSpacers = spacers.lazy.map(\.minWidth).reduce(0, +)
		
		var remainingWidth = proposedWidth - totalSpacing - reservedMinimumSpaceForSpacers
		
		var remainingViewCount = remainingViews.count
		
		var equalChildWidth: Double {
			remainingWidth / Double(remainingViewCount)
		}
		
		func justifyViews(inPartition partition: Partition, proposedLength: (JustifiableNode) -> Double) {
			for view in partition {
				let proposedLength = proposedLength(view)
				view.justify(proposedWidth: proposedLength, proposedHeight: proposedHeight)
				remainingWidth -= view.width
				remainingViewCount -= 1
			}
		}
		
		func justifyViewsWithMinimumSpace() {
			var viewsGreaterThanEqualChildWidth: Partition
			
			repeat {
				
				let p = remainingViews.partition(by: { $0.minWidth >= equalChildWidth })
				
				viewsGreaterThanEqualChildWidth = remainingViews[p...]
				
				remainingViews = remainingViews[..<p]
				
				justifyViews(inPartition: viewsGreaterThanEqualChildWidth) { view in
					view.minWidth
				}
				
			} while !viewsGreaterThanEqualChildWidth.isEmpty
		}
		
		justifyViewsWithMinimumSpace()
		
		let p = remainingViews.partition(by: { $0.maxWidth < equalChildWidth })
		
		let viewsSmallerThanEqualChildWidth = remainingViews[p...]
		
		remainingViews = remainingViews[..<p]
		
		justifyViews(inPartition: viewsSmallerThanEqualChildWidth) { _ in
			equalChildWidth
		}
		
		// Fix for children with maxLength of infinity but actually dont take up infinite space
		
		for view in remainingViews {
			view.justify(proposedWidth: .infinity, proposedHeight: proposedHeight)
		}
		
		let p2 = remainingViews.partition(by: { $0.width < equalChildWidth })
		
		let viewsSmallerThanEqualChildWidth2 = remainingViews[p2...]
		
		justifyViews(inPartition: viewsSmallerThanEqualChildWidth2) { _ in
			equalChildWidth
		}
		
		// Fix for children with maxLength of infinity but actually dont take up infinite space
		
		justifyViews(inPartition: remainingViews) { _ in
			equalChildWidth
		}
		
		remainingWidth += reservedMinimumSpaceForSpacers
		
		remainingViews = spacers
		remainingViewCount = spacers.count
		
		justifyViewsWithMinimumSpace()
		
		justifyViews(inPartition: remainingViews) { _ in
			equalChildWidth
		}
		
		self.width = children.lazy.map(\.width).reduce(0, +) + totalSpacing
		self.height = children.lazy.max(by: { $0.height < $1.height })?.height ?? 0
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
