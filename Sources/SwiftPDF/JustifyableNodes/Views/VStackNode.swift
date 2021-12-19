final class VStackNode: JustifiableNode {
	
	private typealias Partition = Array<JustifiableNode>.SubSequence
	
	private let alignment: HorizontalAlignment
	
	private let spacing: Double
	
	init(alignment: HorizontalAlignment, spacing: Double?) {
		self.alignment = alignment
		self.spacing = spacing ?? Default.spacing
	}
	
	/// Total amout of spacing needed for spacing all children.
	var totalSpacing: Double {
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
		
        // Partition, die keine `SpacerNode`s enthält.
		let otherNodes = children[..<spacerPivot]
		
        // Die Summe, der Mindesthöhe, die die Spacer benötigen.
        let totalSpacerMinHight = spacers.sum(of: \.minHeight)
		
        // Restliche Höhe, die auf `otherNodes` aufgeteilt werden kann.
		var remainingHeight = proposedHeight - totalSpacing - totalSpacerMinHight
		
        // `otherNodes` werden mit `remainingHeight` ausgerichtet.
        var vjustifier = VerticalAxisJustifier(
            nodes: otherNodes,
            proposedWidth: proposedWidth,
            proposedHeight: remainingHeight)
        
        vjustifier.justifyNodes()
        
        // Resthöhe, die von `otherNodes` nicht verwendet wurde
        // und die Mindesthöhe der `SpacerNode`s, die auf den `SpacerNode`s
        // verteilt werden kann.
        remainingHeight = vjustifier.remainingLength + totalSpacerMinHight
        
        // `spacers` werden mit `remainingHeight` ausgerichtet.
        vjustifier = VerticalAxisJustifier(
            nodes: spacers,
            proposedWidth: proposedWidth,
            proposedHeight: remainingHeight)
        
        vjustifier.justifyNodes()
		
        self.width = children.max(of: \.width) ?? 0
        self.height = children.sum(of: \.height) + totalSpacing
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
	
	override func justifyBounds() {
		super.justifyBounds()
		minHeight += totalSpacing
		maxHeight += totalSpacing
	}
}
