final class FrameNode: JustifiableNode {
	let width: Double?
	let height: Double?
	let alignment: Alignment
	
	init(width: Double?, height: Double?, alignment: Alignment) {
		self.width = width
		self.height = height
		self.alignment = alignment
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		let boundary = super.justifyBounds()
		minWidth = width ?? boundary.minW
		minHeight = height ?? boundary.minH
		maxWidth = width ?? boundary.maxW
		maxHeight = height ?? boundary.maxH
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		size.width = self.width ?? proposedWidth
		children.forEach { child in
			child.justifyWidth(proposedWidth: size.width, proposedHeight: proposedHeight)
		}
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		size.height = self.height ?? proposedHeight
		children.forEach { child in
			child.justifyHeight(proposedWidth: proposedWidth, proposedHeight: size.height)
		}
	}
}
