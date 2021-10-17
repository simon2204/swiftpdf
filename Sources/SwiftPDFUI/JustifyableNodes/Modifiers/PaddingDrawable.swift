final class PaddingDrawable: JustifiableNode {
	
	private let insets: EdgeInsets
	
	init(insets: EdgeInsets?) {
		self.insets = insets ?? EdgeInsets(all: Default.spacing)
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let child = children.first {
			let horizontalPadding = insets.leading + insets.trailing
			let verticalPadding = insets.top + insets.bottom
			
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
