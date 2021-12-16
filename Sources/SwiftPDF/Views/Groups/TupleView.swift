/// Eine View, die aus einem Tupel von View-Werten erstellt wird.
///
/// Die `TupleView` wird Hauptsächlich von dem ``ViewBuilder`` verwendet,
/// der mehrere `View`s mit Hilfe der `TupleView` zusammenfügt, um einen einzelnen
/// `return`-Wert zu liefern.
public struct TupleView<T>: View {
    
    /// Wird nur einen Tuple mit View-Werten enthalten.
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
