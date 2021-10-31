final class FrameNode: AlignmentNode {
	private let _width: Double?
	private let _height: Double?
	private let alignment: Alignment
	
	init(width: Double?, height: Double?, alignment: Alignment) {
		self._width = width
		self._height = height
		self.alignment = alignment
	}
	
	override func justifyBounds() {
		if let child = children.first {
			minWidth = _width ?? child.minWidth
			minHeight = _height ?? child.minHeight
			maxWidth = _width ?? child.maxWidth
			maxHeight = _height ?? child.maxHeight
		}
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let child = children.first {
			let proposedChildWidth = self._width ?? proposedWidth
			let proposedChildHeight = self._height ?? proposedHeight
			child.justify(proposedWidth: proposedChildWidth, proposedHeight: proposedChildHeight)
			self.width = self._width ?? child.width
			self.height = self._height ?? child.height
		} else {
			self.width = self._width ?? 0
			self.height = self._height ?? 0
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
}
