final class GeometryReaderDrawable: JustifiableNode {
	var didLayout: ((Rect) -> Void)?
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) -> Double {
		self.size.width = proposedWidth
		return proposedWidth
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) -> Double {
		self.size.height = proposedHeight
		return proposedHeight
	}
	
	override func justify(x: Double) {
		self.origin.x = x
	}
	
	override func justify(y: Double) {
		self.origin.y = y
	}
	
	override func nodeDidJustifySelf() {
		self.didLayout?(Rect(origin: origin, size: size))
		
		children?.forEach { child in
			child.justifyWidth(proposedWidth: size.width, proposedHeight: size.height)
			child.justifyHeight(proposedWidth: size.width, proposedHeight: size.height)
			child.justify(x: origin.x)
			child.justify(y: origin.y)
		}
		
		super.nodeDidJustifySelf()
	}
}
