struct PaddingModifier: ViewModifier {
	
	private let insets: EdgeInsets?
	
	init(insets: EdgeInsets?) {
		self.insets = insets
	}
	
	func body(content: Content) -> some View {
		content
	}
}

extension PaddingModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = PaddingNode(insets: insets)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
    /// Ein Modifikator, der die Ränder mit einer Polsterung versieht.
    ///
    /// Es können ein oder mehrere Kanten übergeben werden, die mit einer bestimmten Länge
    /// gepolstert werden sollen.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             Text("Text, der an der unteren Kante gepolstert wird.")
    ///                 .padding(.bottom)
    ///                 .border(color: Color.gray)
    ///             Text("Text ohne Polsterung")
    ///                 .border(color: Color.yellow)
    ///             Text("Text mit mehreren gepolsterten Kanten.")
    ///                 .padding([.top, .trailing], 16)
    ///                 .border(color: .mint)
    ///         }
    ///     }
    /// }
    /// ```
    /// ![Text mit verschiedenen Polsterungen.](Padding.png)
    ///
    /// - Parameters:
    ///   - edges: Kanten, die gepolstert werden sollen. Standardmäßig werden alle Kanten gepolstert.
    ///   - length: Breite der Polsterung. Bei `nil` wird ein standard Wert verwendet.
	func padding(_ edges: Edge.Set = .all, _ length: Double? = nil) -> some View {
        
        let insetLength = length ?? Default.spacing
        
        var insets = EdgeInsets()
        
        if edges.contains(.leading) {
            insets.leading = insetLength
        }
        
        if edges.contains(.trailing) {
            insets.trailing = insetLength
        }
        
        if edges.contains(.top) {
            insets.top = insetLength
        }
        
        if edges.contains(.bottom) {
            insets.bottom = insetLength
        }
		
		return modifier(PaddingModifier(insets: insets))
	}
	
	/// Ein Modifikator, der die Ränder mit einer Polsterung versieht.
	///
	/// Jeder Rand wird mit einer bestimmten Länge gepolstert.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             Text("Text mit einem Padding von 16.")
    ///                 .padding(16)
    ///                 .border(color: Color.gray)
    ///             Text("Text mit standard Padding.")
    ///                 .padding()
    ///                 .border(color: Color.blue)
    ///             Text("Text ohne Polsterung")
    ///                 .border(color: Color.yellow)
    ///         }
    ///     }
    /// }
    /// ```
	/// ![Text mit verschiedenen Polsterungen.](Padding2.png)
    ///
	/// - Parameter length: Länge der Posterung an jeder Kante.
	func padding(_ length: Double) -> some View {
		modifier(PaddingModifier(insets: EdgeInsets(all: length)))
	}
	
    /// Ein Modifikator, der die Ränder mit einer Polsterung versieht.
    ///
    /// Jedem Rand kann eine andere Länge der Polsterung zugewiesen werden.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         VStack {
    ///             Text("Text mit verschiedenen Posterungen an den Kanten.")
    ///                 .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 32))
    ///                 .border(color: Color.gray)
    ///             Text("Text ohne Polsterung")
    ///                 .border(color: Color.yellow)
    ///         }
    ///     }
    /// }
    /// ```
    /// ![Text mit verschiedenen Polsterungen.](Padding3.png)
    ///
    /// - Parameter insets: Individuelle Länge der Posterung der Kanten.
	func padding(_ insets: EdgeInsets) -> some View {
		modifier(PaddingModifier(insets: insets))
	}
}
