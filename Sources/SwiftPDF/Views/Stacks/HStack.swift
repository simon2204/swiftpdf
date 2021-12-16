/// Eine `View`, die Views entlang der horizontalen Achse ausrichtet.
///
/// Die Kinder des `HStack`s werden entlang der horizontalen Achse ausrichtet,
/// mit einem gewissen Abstand zueinander.
/// Der Abstand zwischen den Kindern kann durch den `spacing`
/// Parameter im Initialiser angepasst werden.
///
/// Beispiel eines HStacks mit verschiedenen Farben als Kinder und dem standard `spacing`:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         HStack {
///             Color.red
///             Color.orange
///             Color.yellow
///         }
///     }
/// }
/// ```
/// ![Horizontaler Stack mit den Farben Rot, Orange und Gelb.](HStack.png)
///
/// Durch setzen des `spacing`-Parameters auf 0, wird der Raum zwischen den Views entfernt:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         HStack(spacing: 0) {
///             Color.red
///             Color.orange
///             Color.yellow
///         }
///     }
/// }
/// ```
/// ![Horizontaler Stack ohne Zwischenräume.](HStackNoSpacing.png)
///
/// Die Kinder des HStacks werden ohne Angabe des alignment-Parameters auf der vertikalen Achse zentriert.
/// Mit dem `alignment`-Parameter, lässt sich die vertikale Ausrichtung der Kinder anpassen.
/// Dem Parameter wird ein Wert des ``VerticalAlignment``s übergeben.
/// Durch ``VerticalAlignment/top`` werden die Kinder an der oberen Kante des HStacks positioniert.
/// Der Unterschied zwischen den verschiedenen Ausrichtungen wird dann deutlich,
/// wenn ein oder mehrere Kinder unterschiedliche Höhen besitzen.
/// Aus diesem Grund bekommt ``Color/red`` eine explizite Höhe von 100,
/// ``Color/orange`` eine Höhe von 50 und
/// ``Color/yellow`` eine Höhe von 25:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         HStack(alignment: .top, spacing: 0) {
///             Color.red.frame(height: 100)
///             Color.orange.frame(height: 50)
///             Color.yellow.frame(height: 25)
///         }
///     }
/// }
/// ```
/// ![Horizontaler Stack mit Top-Alignment.](HStackTop.png)
public struct HStack<Content>: View where Content: View {
    
    let alignment: VerticalAlignment
	let spacing: Double?
    let content: () -> Content
    
    /// Erstellt einen neuen HStack aus den übergebenen Inhalten.
    ///
    /// Die Kinder werden standardmäßig in der Mitte des HStacks ausgerichtet.
    /// Wenn kein Wert für `spacing` übergeben wird, wird der Standard verwendet.
    ///
    /// - Parameters:
    ///   - alignment: Vertikale ausrichtung der Kinder.
    ///   - spacing: Abstand der Kinder zueinander.
    ///   - content: Kinder des Stacks.
    public init(
		alignment: VerticalAlignment = .center,
		spacing: Double? = nil,
        @ViewBuilder content: @escaping () -> Content)
	{
		self.alignment = alignment
		self.spacing = spacing
        self.content = content
    }
}

extension HStack: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
		let drawable = HStackNode(alignment: alignment, spacing: spacing)
        parent.add(child: drawable)
        content().unwrapped().buildTree(drawable)
    }
}
