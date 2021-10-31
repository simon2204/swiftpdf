final class PaddingDrawable: JustifiableNode {
	
	private let insets: EdgeInsets
	
	private var horizontalPadding: Double {
		insets.leading + insets.trailing
	}
	
	private var verticalPadding: Double {
		insets.top + insets.bottom
	}
	
	init(insets: EdgeInsets?) {
		self.insets = insets ?? EdgeInsets(all: Default.spacing)
		
		super.init()
		
		minWidth = self.insets.leading + self.insets.trailing
		minHeight = self.insets.top + self.insets.bottom
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		
		minWidth = horizontalPadding
		minHeight = verticalPadding
		maxWidth = horizontalPadding
		maxHeight = verticalPadding
		
		if let child = children.first {
			let _ = child.justifyBounds()
			minWidth += child.minWidth
			minHeight += child.minWidth
			maxWidth += child.maxWidth
			maxHeight += child.maxHeight
		}
		
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let child = children.first {
			let childWidth = proposedWidth - horizontalPadding
			let childHeight = proposedHeight - verticalPadding
			
			child.justify(proposedWidth: childWidth, proposedHeight: childHeight)
			
			self.width = child.width + horizontalPadding
			self.height = child.height + verticalPadding
		}
	}
	
	override func justify(x: Double) {
		self.x = x
		children.first?.justify(x: x + insets.leading)
	}
	
	override func justify(y: Double) {
		self.y = y
		children.first?.justify(y: y + insets.bottom)
	}
}
