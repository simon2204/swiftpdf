struct FrameModifier: ViewModifier {
    /// Breite des Rahmens. Bei `nil` wird die Breite durch das Layoutsystem festgelegt.
	let width: Double?
    /// Höhe des Rahmens. Bei `nil` wird die Höhe durch das Layoutsystem festgelegt.
	let height: Double?
    /// Positionierung des Inhaltes innerhalb dieser `View`.
	let alignment: Alignment
	
	func body(content: Content) -> some View {
		content
	}
}

extension FrameModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = FrameNode(width: width, height: height, alignment: alignment)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
    /// Positioniert diese Ansicht innerhalb eines unsichtbaren Rahmens mit der angegebenen Größe.
    ///
    /// Hier ein Beispiel, wie sich die Rechtecke mit unterschiedlicher Breite innerhalb des Rahmens dimensionieren:
    /// ```swift
    /// struct ContentView: View {
    ///
    ///     let cornerRadius: Double = 20
    ///     let fixedHeight: Double = 200
    ///
    ///     var body: some View {
    ///         VStack {
    ///             RoundedRectangle(cornerRadius: cornerRadius)
    ///                 .fill(.green)
    ///                 .frame(width: 200, height: fixedHeight)
    ///             RoundedRectangle(cornerRadius: cornerRadius)
    ///                 .fill(.blue)
    ///                 .frame(width: 400, height: fixedHeight)
    ///         }
    ///     }
    /// }
    /// ```
    /// ![Zwei Recktecke innerhalb eines Rahmens](Frame.png)
    ///
    /// - Parameters:
    ///   - width: Eine feste Breite des Rahmens. Bei `nil` verhält sich die Breite entsprechend wie die Breite, auf die der Modifikator angewandt wurde.
    ///   - height: Eine feste Höhe des Rahmens. Bei `nil` verhält sich die Höhe entsprechend wie die Höhe, auf die der Modifikator angewandt wurde.
    ///   - alignment: Die Ausrichtung der `View` innerhalb des Rahmens.
    /// - Returns: Eine `View` mit festen Werten für die Höhe und Breite, wenn diese nicht mit `nil` belegt wurden.
	func frame(width: Double? = nil, height: Double? = nil, alignment: Alignment = .center) -> some View {
		modifier(FrameModifier(width: width, height: height, alignment: alignment))
	}
}

