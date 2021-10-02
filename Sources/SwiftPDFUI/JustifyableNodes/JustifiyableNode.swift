class JustifiableNode {

    var origin: Point = .zero
    
	var size: Size = .zero
    
    private(set) weak var parent: JustifiableNode?
    
    private(set) var children: [JustifiableNode]?
    
    func add(child: JustifiableNode) {
        child.parent = self
        
        if children?.append(child) == nil {
            children = [child]
        }
    }
	
	func replace(node: JustifiableNode, with nodes: [JustifiableNode]) {
		
		let index = children?.firstIndex(where: { child in
			child === node
		}) ?? 0
		
		children?.remove(at: index)
		
		children?.insert(contentsOf: nodes, at: index)
	}
	
	func nodeWillJustifySelf() {
		children?.forEach { child in
			child.nodeWillJustifySelf()
		}
	}
	
	func nodeDidJustifySelf() {
		children?.forEach { child in
			child.nodeDidJustifySelf()
		}
	}
    
	@discardableResult
    func justifyWidth(proposedWidth: Double, proposedHeight: Double) -> Double {
        size.width = proposedWidth
        
        children?.forEach { child in
            child.justifyWidth(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
        }
        
        return proposedWidth
    }
    
	@discardableResult
    func justifyHeight(proposedWidth: Double, proposedHeight: Double) -> Double {
        size.height = proposedHeight
        
        children?.forEach { child in
            child.justifyHeight(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
        }
        
        return proposedHeight
    }
    
    func draw(in context: GraphicsContext) {
        children?.forEach { child in
            child.draw(in: context)
        }
    }
	
	func justify(x: Double) {
		self.origin.x = x
		
		children?.forEach { child in
			child.justify(x: x)
		}
	}
	
	func justify(y: Double) {
		self.origin.y = y
		
		children?.forEach { child in
			child.justify(y: y)
		}
	}
}
