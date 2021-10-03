final class PaddingDrawable: JustifiableNode {
	let length: Double
	
	init(length: Double?) {
		self.length = length ?? Default.spacing
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		let childWidth = proposedWidth - 2 * length
		let childHeight = proposedHeight - 2 * length
		
		children.forEach { child in
			child.justifyWidth(proposedWidth: childWidth, proposedHeight: childHeight)
			self.size.width = child.size.width + 2 * length
		}
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		let childWidth = proposedWidth - 2 * length
		let childHeight = proposedHeight - 2 * length
		
		children.forEach { child in
			child.justifyHeight(proposedWidth: childWidth, proposedHeight: childHeight)
			self.size.height = child.size.height + 2 * length
		}
	}
	
	override func justify(x: Double) {
		self.origin.x = x
		
		children.forEach { child in
			child.justify(x: x + length)
		}
	}
	
	override func justify(y: Double) {
		self.origin.y = y
		
		children.forEach { child in
			child.justify(y: y + length)
		}
	}
}
