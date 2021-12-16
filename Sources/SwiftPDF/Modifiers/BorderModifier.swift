struct BorderModifier: ViewModifier {
    /// Farbe der Umrandung.
	let color: Color
    /// Breite der Umrandung.
    let width: Double
	
	func body(content: Content) -> some View {
		content
	}
}

extension BorderModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
        let node = BorderNode(color: color, width: width)
		parent.add(child: node)
		content.buildTree(node)
	}
}

public extension View {
    /// Zeichnet eine farbige Umrandung mit einer bestimmten Breite.
    ///
    /// Dieser Modifikator zeichnet eine Umrandung um den Rahmen dieser `View`.
    /// Die Umrandung wird innerhalb des Rahmens gezeichnet.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Text("Farbige Umrandung, innerhalb des Text-Rahmens.")
    ///             .fontSize(16)
    ///             .border(color: .mint, width: 4)
    ///     }
    /// }
    /// ```
    /// ![Farbige Umrandung innerhalb des Text-Rahmens.](Border.png)
    ///
    /// Um die Umrandung außerhalb des Rahmens zu zeichen,
    /// kann ein zusätzliches ``View/padding(_:)-4nkjg`` mit der Breite
    /// der Umrandung verwendet werden, bevor die Umrandung gezeichnet wird.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///     var body: some View {
    ///         Text("Farbige Umrandung, außerhalb des Text-Rahmens.")
    ///             .padding(4)
    ///             .border(color: .mint, width: 4)
    ///     }
    /// }
    /// ```
    /// ![Farbige Umrandung außerhalb des Text-Rahmens.](BorderPadding.png)
    ///
    /// - Parameters:
    ///   - color: Farbe der Umrandung.
    ///   - width: Breite der Umrandung. Der Standard ist 1.
    /// - Returns: Liefert eine neue `View` mit einer Umrandung.
    func border(color: Color, width: Double = 1) -> some View {
		modifier(BorderModifier(color: color, width: width))
	}
}
