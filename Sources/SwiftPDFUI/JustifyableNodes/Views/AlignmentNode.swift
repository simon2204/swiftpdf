class AlignmentNode: JustifiableNode {
	
	/// Width of the widest child.
	///
	/// If there is no child and therefore no maximum, zero will be returned.
	final var maximumWidthOfChildren: Double {
		children.lazy.map(\.width).max() ?? 0
	}
	
	/// Height of the tallest child.
	///
	/// If there is no child and therefore no maximum, zero will be returned.
	final var maximumHeightOfChildren: Double {
		children.lazy.map(\.height).max() ?? 0
	}
	
	// MARK: - Horizontal Alignment

	/// Aligns all children at the leading edge of the stack.
	func alignChildrenLeading() {
		for child in children {
			child.justify(x: self.x)
		}
	}
		
	/// Centers all children horizontally in the stack.
	func centerChildrenHorizontally() {
		for child in children {
			let x = (self.width - child.width) / 2
			child.justify(x: x + self.x)
		}
	}
	
	/// Aligns all children at the trailing edge of the stack.
	func alignChildrenTrailing() {
		for child in children {
			let x = self.width - child.width
			child.justify(x: x + self.x)
		}
	}
	
	// MARK: - Vertical Alignment
	
	/// Aligns all children at the top edge of the stack.
	func alignChildrenTop() {
		for child in children {
			let y = self.height - child.height
			child.justify(y: y + self.y)
		}
	}
	
	/// Centers all children vertically in the stack.
	func centerChildrenVertically() {
		for child in children {
			let y = (self.height - child.height) / 2
			child.justify(y: y + self.y)
		}
	}
	
	/// Aligns all children at the bottom edge of the stack.
	func alignChildrenBottom() {
		for child in children {
			child.justify(y: self.y)
		}
	}
}
