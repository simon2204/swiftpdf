final class FrameNode: JustifiableNode {
	let width: Double?
	let height: Double?
	let alignment: Alignment
	
	init(width: Double?, height: Double?, alignment: Alignment) {
		self.width = width
		self.height = height
		self.alignment = alignment
	}
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) -> Double {
		size.width = width ?? proposedWidth
		
		children?.forEach { child in
			child.justifyHeight(proposedWidth: size.width, proposedHeight: proposedHeight)
		}
		
		return size.width
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) -> Double {
		size.height = height ?? proposedHeight
		
		children?.forEach { child in
			child.justifyHeight(proposedWidth: proposedWidth, proposedHeight: size.height)
		}
		
		return size.width
	}
}
