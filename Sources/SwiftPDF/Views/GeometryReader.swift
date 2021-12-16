/// Eine `View` zum Auslesen des zugeteilten Bereiches.
///
/// Der `GeometryReader` liest aus dem Layoutsystem die Größe aus, die ihm zugeteilt wird.
public struct GeometryReader<Content>: View where Content: View {
    /// Closure, die die Größe des Bereiches Liefert
    /// und eine `View` als Rückgabe erwartet.
	let content: (Rect) -> Content
    
    /// Erstellt einen `GeometryReader`, der den zugewiesenen Bereich ausliest.
    /// - Parameter content: Closure, die die Größe des Bereiches Liefert
    /// und eine `View` als Rückgabe erwartet.
	public init(content: @escaping (Rect) -> Content) {
		self.content = content
	}
}

extension GeometryReader: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		
		let node = GeometryReaderNode()
		
		parent.add(child: node)
		
		node.didLayout = { frame in
			content(frame).unwrapped().buildTree(node)
		}
	}
}
