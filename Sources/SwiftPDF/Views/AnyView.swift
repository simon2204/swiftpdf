/// Typeeraser einer `View`.
public struct AnyView: View {
    /// Enthält die ursprüngliche `View`.
	let storage: Any

    /// Erstellt eine `AnyView` aus der übergebenen `View`.
    /// - Parameter view: `View`, dessen Typ entfernt werden soll.
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
