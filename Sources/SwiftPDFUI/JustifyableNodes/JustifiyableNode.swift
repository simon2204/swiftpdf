class JustifiableNode {
	
	var origin: Point = .zero
	
	@Clamping(lowerBound: .zero)
	private var width: Double = .zero
	
	@Clamping(lowerBound: .zero)
	private var height: Double = .zero
	
	var size: Size {
		get { Size(width: width, height: height) }
		set { width = newValue.width; height = newValue.height }
	}
    
    private(set) weak var parent: JustifiableNode?
    
    var children: [JustifiableNode] = []
	
    func add(child: JustifiableNode) {
        child.parent = self
        children.append(child)
    }
	
	// MARK: - Drawing
        
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
	
	func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		children.forEach { child in
			child.justifyWidth(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
			width += child.width
		}
	}
	
	func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		children.forEach { child in
			child.justifyHeight(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
			height += child.height
		}
	}

	func justify(x: Double) {
		self.origin.x = x
		children.forEach { child in
			child.justify(x: x)
		}
	}
	
	func justify(y: Double) {
		self.origin.y = y
		children.forEach { child in
			child.justify(y: y)
		}
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

@propertyWrapper
struct Clamping<Value: Comparable> {
	var value: Value
	let lowerBound: Value

	init(wrappedValue: Value, lowerBound: Value) {
		self.value = wrappedValue
		self.lowerBound = lowerBound
	}

	var wrappedValue: Value {
		get { value }
		set { value = max(lowerBound, newValue) }
	}
}
