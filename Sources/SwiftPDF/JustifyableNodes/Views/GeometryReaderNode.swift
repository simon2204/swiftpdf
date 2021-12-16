final class GeometryReaderNode: JustifiableNode {
	
	var didLayout: ((Rect) -> Void)?
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		self.width = proposedWidth
		self.height = proposedHeight
	}
	
	override func justify(x: Double) {
		self.x = x
	}
	
	override func justify(y: Double) {
		self.y = y
	}
	
	override func nodeDidJustify() {
		didLayout?(frame)
		
		if let child = children.first {
			child.justify(proposedWidth: width, proposedHeight: height)
			child.justify(x: x)
			child.justify(y: y)
		}
		
		super.nodeDidJustify()
	}
}
