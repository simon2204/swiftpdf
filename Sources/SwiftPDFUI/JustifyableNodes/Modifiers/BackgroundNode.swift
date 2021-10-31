final class BackgroundNode: AlignmentNode {
	
	let alignment: Alignment
	
	init(alignment: Alignment) {
		self.alignment = alignment
	}
	
	override func justifyBounds() {
		if let foreground = children.first {
			foreground.justifyBounds()
			self.minWidth = foreground.minWidth
			self.minHeight = foreground.minHeight
			self.maxWidth = foreground.maxWidth
			self.maxHeight = foreground.maxHeight
		}
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let foreground = children.first {
			foreground.justify(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
			
			self.width = foreground.width
			self.height = foreground.height
			
			if let background = children.last {
				background.justify(proposedWidth: self.width, proposedHeight: self.height)
			}
		}
	}
	
	override func justify(x: Double) {
		self.x = x
		
		switch alignment.horizontal {
		case .leading:
			alignChildrenLeading()
			
		case .center:
			centerChildrenHorizontally()
			
		case .trailing:
			alignChildrenTrailing()
		}
	}
	
	override func justify(y: Double) {
		self.y = y
		
		switch alignment.vertical {
		case .top:
			alignChildrenTop()
			
		case .center:
			centerChildrenVertically()
			
		case .bottom:
			alignChildrenBottom()
			
		default:
			centerChildrenVertically()
		}
	}
	
	override func draw(in context: GraphicsContext) {
		
		if let background = children.last {
			background.draw(in: context)
		}
		
		if let foreground = children.first {
			foreground.draw(in: context)
		}
	}
}
