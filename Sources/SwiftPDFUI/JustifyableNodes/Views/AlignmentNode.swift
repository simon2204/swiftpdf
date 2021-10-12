class AlignmentNode: JustifiableNode {
	
	/// Width of the widest child.
	///
	/// If there is no child and therefore no maximum, zero will be returned.
	var maximumWidthOfChildren: Double {
		children.lazy.map(\.size.width).max() ?? 0
	}
	
	/// Height of the tallest child.
	///
	/// If there is no child and therefore no maximum, zero will be returned.
	var maximumHeightOfChildren: Double {
		children.lazy.map(\.size.height).max() ?? 0
	}
	
	// MARK: - Horizontal Alignment
	
	/// Aligns all children at the leading edge of the stack.
	func alignChildrenLeading() {
		for child in children {
			child.justify(x: origin.x)
		}
	}
	
	/// Centers all children horizontally in the stack.
	func centerChildrenHorizontally() {
		for child in children {
			let x = (size.width - child.size.width) / 2
			child.justify(x: x + origin.x)
		}
	}
	
	/// Aligns all children at the trailing edge of the stack.
	func alignChildrenTrailing() {
		for child in children {
			let x = size.width - child.size.width
			child.justify(x: x + origin.x)
		}
	}
	
	// MARK: - Vertical Alignment
	
	/// Aligns all children at the top edge of the stack.
	func alignChildrenTop() {
		for child in children {
			let y = size.height - child.size.height
			child.justify(y: y + origin.y)
		}
	}
	
	/// Centers all children vertically in the stack.
	func centerChildrenVertically() {
		for child in children {
			let y = (size.height - child.size.height) / 2
			child.justify(y: y + origin.y)
		}
	}
	
	/// Aligns all children at the bottom edge of the stack.
	func alignChildrenBottom() {
		for child in children {
			child.justify(y: origin.y)
		}
	}
}
