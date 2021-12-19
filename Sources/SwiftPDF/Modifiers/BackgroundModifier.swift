struct BackgroundModifier<Background, Foreground>: ViewModifier where Background: View, Foreground: View {
    /// Positionierung des Hintergrundes in dem Rahmen des Vordergrundes.
	let alignment: Alignment
	
	let background: Background
	
	let foreground: Foreground
	
	func body(content: Content) -> some View {
		content
	}
}

extension BackgroundModifier: PrimitiveModifier {
	func buildTree(_ parent: JustifiableNode, content: PrimitiveView) {
		let node = BackgroundNode(alignment: alignment)
		parent.add(child: node)
		foreground.unwrapped().buildTree(node)
		background.unwrapped().buildTree(node)
	}
}

public extension View {
    /// Positioniert eine `View` hinter einer anderen.
    ///
    /// Mit dem `background`-Modifier kann eine `View` übergeben werden,
    /// die hinter der auf der angewendeten `View` positioniert wird.
    /// Dabei wird der `View` im Hintergrund nur der Platz zugeteilt,
    /// den auch die View im Vordergrund bekommt.
    ///
    /// Mehrere `View`s können dem Modifikator als Hintergrund übergeben werden.
    /// Übergebene `View`s werden implizit in einen ``ZStack`` gepackt,
    /// die in der Reihenfolge von hinten nach vorne erscheinen.
    ///
    /// ```swift
    /// struct ContentView: View {
    ///
    ///     let strokeWidth: Double = 10
    ///
    ///     var body: some View {
    ///         Text("Hello, World!")
    ///             .fontSize(50)
    ///             .padding()
    ///             .background {
    ///                 Ellipse().fill(.brown)
    ///                 Ellipse().stroke(.yellow, lineWidth: strokeWidth)
    ///                 Ellipse().stroke(.red, lineWidth: strokeWidth / 4)
    ///             }
    ///             .padding(strokeWidth / 2)
    ///     }
    /// }
    /// ```
    /// !["Hello World!" Schriftzug mit einem Hintergrund aus mehreren Ellipsen.](BackgroundMultiple.png)
    ///
    /// In diesem Beispiel werden mehrere ``Text``e hinter einem großen Text platziert.
    /// Damit die Texte nicht übereinander erscheinen,
    /// wird jeweils ein anderer Wert von ``Alignment`` übergeben:
    ///
    /// ```swift
    /// struct ContentView: View {
    ///
    ///     let greeting = "Hello, World!"
    ///
    ///     var body: some View {
    ///         Text(greeting)
    ///             .fontSize(50)
    ///             .background(alignment: .topLeading) {
    ///                 Text(greeting)
    ///                     .foregroundColor(.red)
    ///             }
    ///             .background(alignment: .center) {
    ///                 Text(greeting)
    ///                     .foregroundColor(.green)
    ///             }
    ///             .background(alignment: .bottomTrailing) {
    ///                 Text(greeting)
    ///                     .foregroundColor(.blue)
    ///             }
    ///     }
    /// }
    /// ```
    /// ![Großer Hello, World! Schriftzug im Vordergrund, mit drei kleineren Versionen im Hintergrund.](Background.png)
    ///
    /// - Parameters:
    ///   - alignment: Die Ausrichtung der `View` hinter dem Vordergrund. Der Standard ist ``Alignment/center``.
    ///   - content: Hintergrund der neuen `View`.
    /// - Returns: Neue `View` zusammengesetzt aus Vordergrund und Hintergrund.
	func background<V>(alignment: Alignment = .center, @ViewBuilder _ content: @escaping () -> V) -> some View where V : View {
        modifier(BackgroundModifier(alignment: alignment, background: ZStack(content: content), foreground: self))
	}
}
