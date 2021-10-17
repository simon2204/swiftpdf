public struct AnyView: View {

	let storage: Any

    public init<V>(_ view: V) where V: View {
        self.storage = view
    }
}

extension AnyView: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
        let view = transform(storage) { storage in
            storage as! View
        }
        view.unwrapped().buildTree(parent)
    }
    
    private func transform<T, U>(_ input: T, function: (T) -> U) -> U {
        return function(input)
    }
}
