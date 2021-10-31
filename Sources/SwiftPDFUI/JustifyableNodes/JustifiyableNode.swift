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
	
	/// Origin at which the node will be drawn.
	var origin: Point {
		Point(x: x, y: y)
	}
	
	/// Dimentions for the node on the canvas.
	var size: Size {
		Size(width: width, height: height)
	}
	
	/// Frame that describes the origin and size of this node.
	var frame: Rect {
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
	
	/// Minimum width the node can have.
	///
	/// A minimum width of zero means that
	/// the node is able to give up all its space.
	///
	/// `minWidth` will be determined before
	/// `justify(proposedWidth:proposedHeight:)`
	/// gets called.
	var minWidth: Double = .zero
	
	/// Minimum height the node can have.
	///
	/// A minimum height of zero means that
	/// the node is able to give up all its space.
	///
	/// `minHeight` will be determined before
	/// `justify(proposedWidth:proposedHeight:)`
	/// gets called.
	var minHeight: Double = .zero
	
	/// Maximum width the node can have.
	///
	/// A maximum width of infinity means
	/// that the node can fully expand to the width it is given to.
	///
	/// `maxWidth` will be determined before
	/// `justify(proposedWidth:proposedHeight:)`
	/// gets called.
	var maxWidth: Double = .zero
	
	/// Maximum height the node can have.
	///
	/// A maximum height of infinity means
	/// that the node can fully expand to the height it is given to.
	///
	/// `maxHeight` will be determined before
	/// `justify(proposedWidth:proposedHeight:)`
	/// gets called.
	var maxHeight: Double = .zero
	
	func justifyBounds() {
		for child in children {
			child.justifyBounds()
			self.minWidth += child.minWidth
			self.minHeight += child.minHeight
			self.maxWidth += child.maxWidth
			self.maxHeight += child.maxHeight
		}
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
	
	/// Positions the node and all children at the given x-coordinate.
	/// - Parameter x: Position to place the node at.
	func justify(x: Double) {
		self.x = x
		children.first?.justify(x: x)
	}
	
	/// Positions the node and all children at the given y-coordinate.
	/// - Parameter y: Position to place the node at.
	func justify(y: Double) {
		self.y = y
		children.first?.justify(y: y)
	}
	
	// MARK: - Event Handling
	
	/// Gets called when the node has justified its origin and dimentions.
	///
	/// Override this method if you want to respond to this event.
	func nodeDidJustify() {
		children.forEach { child in
			child.nodeDidJustify()
		}
	}
}
