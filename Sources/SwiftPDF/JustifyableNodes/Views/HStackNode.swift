final class HStackNode: JustifiableNode {
	
	private typealias Partition = Array<JustifiableNode>.SubSequence
    
	/// Vertical alignment of children.
    private let alignment: VerticalAlignment
    
	/// Spacing between children.
    private let spacing: Double
    
    init(alignment: VerticalAlignment, spacing: Double?) {
        self.alignment = alignment
		self.spacing = spacing ?? Default.spacing
    }
	
	/// Total amout of spacing needed for spacing all children.
	private var totalSpacing: Double {
		// Count of spacings needed to have one spacing beween each child.
		let spacingCount = Double(children.count) - 1
		return spacingCount * spacing
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		
        // `self.children` wird nach `children` kopiert,
        // um die Reihenfolge von `self.children`
        // nicht durch partitionieren zu verändern.
		var children = self.children
		
        // Ab diesem index enthält `children` nur noch `SpacerNode`s.
		let spacerPivot = children.partition(by: { $0 is SpacerNode })
		
        // Partition mit den `SpacerNode`s
		let spacers = children[spacerPivot...]
		
        // Partition die keine `SpacerNode`s enthält.
		let otherNodes = children[..<spacerPivot]
		
        // Die Summe, der Mindestbreite, die die Spacer benötigen.
        let totalSpacerMinWidth = spacers.sum(of: \.minWidth)
		
        // Restliche Breite, die auf `otherNodes` aufgeteilt werden kann.
		var remainingWidth = proposedWidth - totalSpacing - totalSpacerMinWidth
		
        // `otherNodes` werden mit `remainingWidth` ausgerichtet.
        var hjustifier = HorizontalAxisJustifier(
            nodes: otherNodes,
            proposedWidth: remainingWidth,
            proposedHeight: proposedHeight)
        
        hjustifier.justifyNodes()
        
        // Restbreite, die von `otherNodes` nicht verwendet wurde
        // und die Mindestbreite der `SpacerNode`s, die auf den `SpacerNode`s
        // verteilt werden kann.
        remainingWidth = hjustifier.remainingLength + totalSpacerMinWidth
		
        // `spacers` werden mit `remainingWidth` ausgerichtet.
        hjustifier = HorizontalAxisJustifier(
            nodes: spacers,
            proposedWidth: remainingWidth,
            proposedHeight: proposedHeight)
        
        hjustifier.justifyNodes()
        
        self.width = children.sum(of: \.width) + totalSpacing
        self.height = children.max(of: \.height) ?? 0
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
		}
	}
	
	override func justifyBounds() {
		super.justifyBounds()
		minWidth += totalSpacing
		maxWidth += totalSpacing
	}
}


