final class PaddingDrawable: JustifiableNode {
	
	private let length: Double
	
	init(length: Double?) {
		self.length = length ?? Default.spacing
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		let paddingSum = 2 * length
		
		let childWidth = proposedWidth - paddingSum
		let childHeight = proposedHeight - paddingSum
		
		if let child = children.first {
			child.justify(proposedWidth: childWidth, proposedHeight: childHeight)
			self.width = child.width + paddingSum
			self.height = child.height + paddingSum
		}
	}
	
	override func justify(x: Double) {
		self.x = x
		children.first?.justify(x: x + length)
	}
	
	override func justify(y: Double) {
		self.y = y
		children.first?.justify(y: y + length)
	}
}
