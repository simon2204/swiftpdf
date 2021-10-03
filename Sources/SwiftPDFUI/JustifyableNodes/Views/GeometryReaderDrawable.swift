final class GeometryReaderDrawable: JustifiableNode {
	var didLayout: ((Rect) -> Void)?
	
	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		size.width = proposedWidth
	}
	
	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		size.height = proposedHeight
	}
	
	override func justify(x: Double) {
		origin.x = x
	}
	
	override func justify(y: Double) {
		origin.y = y
	}
	
	override func nodeDidJustifyAchsis() {
		didLayout?(Rect(origin: origin, size: size))
		
		children.forEach { child in
			child.justifyWidth(proposedWidth: size.width, proposedHeight: size.height)
			child.justifyHeight(proposedWidth: size.width, proposedHeight: size.height)
			child.justify(x: origin.x)
			child.justify(y: origin.y)
		}
		
		super.nodeDidJustifyAchsis()
	}
}
