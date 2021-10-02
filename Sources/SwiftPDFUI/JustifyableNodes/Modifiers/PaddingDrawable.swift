final class PaddingDrawable: JustifiableNode {
	let length: Double
	
	init(length: Double) {
		self.length = length
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) -> Double {
		let childWidth = proposedWidth - 2 * length
		let childHeight = proposedHeight - 2 * length
		
		children?.forEach { child in
			let width = child.justifyWidth(proposedWidth: childWidth, proposedHeight: childHeight)
			self.size.width = width + 2 * length
		}
		
		return self.size.width
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) -> Double {
		let childWidth = proposedWidth - 2 * length
		let childHeight = proposedHeight - 2 * length
		
		children?.forEach { child in
			let height = child.justifyHeight(proposedWidth: childWidth, proposedHeight: childHeight)
			self.size.height = height + 2 * length
		}
		
		return self.size.height
	}
	
	override func justify(x: Double) {
		self.origin.x = x
		
		children?.forEach { child in
			child.justify(x: x + length)
		}
	}
	
	override func justify(y: Double) {
		self.origin.y = y
		
		children?.forEach { child in
			child.justify(y: y + length)
		}
	}
}
