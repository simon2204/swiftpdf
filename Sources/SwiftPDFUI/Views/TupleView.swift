public struct TupleView<T>: View {
    
	var value: T
	
    public init(_ value: T) {
        self.value = value
    }
}

extension TupleView: PrimitiveView {
    func buildTree(_ parent: Node) {
		let drawable = TupleDrawable()
		
		let node = Node(drawable)
		
		parent.children.append(node)
		
		let reflection = Mirror(reflecting: value)
		
        let descendents = reflection.children
        
		let childViews = descendents.lazy.compactMap { descendent in
            descendent.value as? View // Impossible cast, yet it's working.
        }
		
		let childPrimitives = childViews.map { childView in
			childView.unwrapped()
		}
		
		childPrimitives.forEach { childPrimitive in
			childPrimitive.buildTree(node)
        }
    }
}
