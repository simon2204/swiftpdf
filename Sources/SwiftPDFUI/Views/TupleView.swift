public struct TupleView<T>: View {
    
	var value: T
	
    public init(_ value: T) {
        self.value = value
    }
}

extension TupleView: PrimitiveView {
    func buildTree(_ parent: Node) {
        let children = Mirror(reflecting: value).children
        
        let childNodes = children.lazy.map { child in
            Node((child.value as! View).unwrapped()) // Impossible cast
        }
        
        childNodes.forEach {
            parent.children.append($0)
            parent.content.buildTree($0)
        }
    }
}
