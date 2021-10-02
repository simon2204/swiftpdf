public struct TupleView<T>: View {
    
	var value: T
	
    init(_ value: T) {
        self.value = value
    }
}

extension TupleView: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
		let reflection = Mirror(reflecting: value)
		
        let descendents = reflection.children
        
		let childViews = descendents.lazy.compactMap { descendent in
            descendent.value as? View
        }
		
		let childPrimitives = childViews.map { childView in
			childView.unwrapped()
		}
		
		childPrimitives.forEach { childPrimitive in
			childPrimitive.buildTree(parent)
        }
    }
}
