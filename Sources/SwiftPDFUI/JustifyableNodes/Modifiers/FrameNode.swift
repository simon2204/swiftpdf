final class FrameNode: JustifiableNode {
	private let _width: Double?
	private let _height: Double?
	private let alignment: Alignment
	
	init(width: Double?, height: Double?, alignment: Alignment) {
		self._width = width
		self._height = height
		self.alignment = alignment
	}
	
	override func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		let boundary = super.justifyBounds()
		minWidth = _width ?? boundary.minW
		minHeight = _height ?? boundary.minH
		maxWidth = _width ?? boundary.maxW
		maxHeight = _height ?? boundary.maxH
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		self.width = self._width ?? proposedWidth
		self.height = self._height ?? proposedHeight
		for child in children {
			child.justify(proposedWidth: self.width, proposedHeight: self.height)
		}
	}
}
