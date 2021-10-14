class JustifiableNode {
	
	/// Node's x-coordinate at which the node is drawn.
	var x: Double = .zero
	
	/// Node's y-coordinate at which the node is drawn.
	var y: Double = .zero
	
	/// Node's width to be drawn on the canvas.
	private var _width: Double = .zero
	
	/// Node's height to be drawn on the canvas.
	private var _height: Double = .zero
	
	/// Node's width to be drawn on the canvas.
	///
	/// The width cannot be smaller than zero.
	var width: Double {
		
		get { _width }
		
		set {
			if newValue >= .zero {
				_width = newValue
			}
		}
	}
	
	/// Node's height to be drawn on the canvas.
	///
	/// The height cannot be smaller than zero.
	var height: Double {
		
		get { _height }
		
		set {
			if newValue >= .zero {
				_height = newValue
			}
		}
	}
    
	/// Parent of the current node.
	///
	/// If the current node is the root, it does not have a parent.
    private(set) weak var parent: JustifiableNode?
    
	/// Children of the current node.
	///
	/// If the current node is a leaf, it does not have children.
	private(set) var children: [JustifiableNode] = []
	
	
	final var origin: Point {
		Point(x: x, y: y)
	}
	
	final var size: Size {
		Size(width: width, height: height)
	}
	
	final var frame: Rect {
		Rect(origin: origin, size: size)
	}
	
	/// Adds a new child to the current node.
	///
	/// - Parameter child: Child to add to the current node.
    func add(child: JustifiableNode) {
        child.parent = self
        children.append(child)
    }
	
	// MARK: - Drawing
	
	/// Draws itself into the given context at position `self.x` and `self.y`
	/// with dimensions of `self.width` and `self.height`.
	///
	/// - Parameter context: The context where the node gets drawn to.
    func draw(in context: GraphicsContext) {
		children.forEach { child in
            child.draw(in: context)
        }
    }
	
	// MARK: - Node's Boundary
	
	var minWidth: Double = .zero
	var minHeight: Double = .zero
	var maxWidth: Double = .zero
	var maxHeight: Double = .zero
	
	func justifyBounds() -> (minW: Double, minH: Double, maxW: Double, maxH: Double) {
		for child in children {
			let boundary = child.justifyBounds()
			self.minWidth += boundary.minW
			self.minHeight += boundary.minH
			self.maxWidth += boundary.maxW
			self.maxHeight += boundary.maxH
		}
		return (minWidth, minHeight, maxWidth, maxHeight)
	}
	
	// MARK: - Justify Node
	
	/// Justifies the size of the node.
	///
	/// The parent node proposes a size to its child nodes.
	/// Each child then chooses its own size based on the proposed size,
	/// but a child does not have to use the proposed size
	/// and can choose their own size.
	///
	/// - Parameters:
	///   - proposedWidth: Proposed width as guidance for justifying width.
	///   - proposedHeight: Proposed height as guidance for justifying height.
	func justify(proposedWidth: Double, proposedHeight: Double) {
		if let child = children.first {
			child.justify(
				proposedWidth: proposedWidth,
				proposedHeight: proposedHeight
			)
			self.width = child.width
			self.height = child.height
		}
	}
	
	func justify(x: Double) {
		self.x = x
		children.first?.justify(x: x)
	}
	
	func justify(y: Double) {
		self.y = y
		children.first?.justify(y: y)
	}
	
	// MARK: - Event Handling
	
	func nodeWillJustifyBounds() {
		children.forEach { child in
			child.nodeWillJustifyBounds()
		}
	}
	
	func nodeDidJustifyBounds() {
		children.forEach { child in
			child.nodeDidJustifyBounds()
		}
	}
	
	func nodeWillJustifySize() {
		children.forEach { child in
			child.nodeWillJustifySize()
		}
	}
	
	func nodeDidJustifySize() {
		children.forEach { child in
			child.nodeDidJustifySize()
		}
	}
	
	func nodeWillJustifyAchsis() {
		children.forEach { child in
			child.nodeWillJustifyAchsis()
		}
	}
	
	func nodeDidJustifyAchsis() {
		children.forEach { child in
			child.nodeDidJustifyAchsis()
		}
	}
	
	func nodeWillDrawSelf() {
		children.forEach { child in
			child.nodeWillDrawSelf()
		}
	}
	
	func nodeDidDrawSelf() {
		children.forEach { child in
			child.nodeDidDrawSelf()
		}
	}
}
