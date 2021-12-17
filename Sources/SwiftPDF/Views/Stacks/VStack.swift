/// Eine `View`, die Views entlang der vertikalen Achse ausrichtet.
///
/// Die Kinder des `VStack`s werden entlang der vertikalen Achse ausrichtet,
/// mit einem gewissen Abstand zueinander.
/// Der Abstand zwischen den Kindern kann durch den `spacing`
/// Parameter im Initialiser angepasst werden.
///
/// Beispiel eines VStacks mit verschiedenen Farben als Kinder und dem standard `spacing`:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         VStack {
///             Color.green
///             Color.blue
///             Color.purple
///         }
///     }
/// }
/// ```
/// ![Vertikaler Stack mit den Farben Grün, Blau und Lila.](VStack.png)
///
/// Durch setzen des `spacing`-Parameters auf 0, wird der Raum zwischen den Views entfernt:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         VStack(spacing: 0) {
///             Color.green
///             Color.blue
///             Color.purple
///         }
///     }
/// }
/// ```
/// ![Vertikaler Stack ohne Zwischenräume.](VStackNoSpacing.png)
///
/// Die Kinder des VStacks werden ohne Angabe des alignment-Parameters auf der horizontalen Achse zentriert.
/// Mit dem `alignment`-Parameter, lässt sich die horizontale Ausrichtung der Kinder anpassen.
/// Dem Parameter wird ein Wert des ``HorizontalAlignment``s übergeben.
/// Durch ``HorizontalAlignment/leading`` werden die Kinder an der linken Kante des VStacks positioniert.
/// Der Unterschied zwischen den verschiedenen Ausrichtungen wird dann deutlich,
/// wenn ein oder mehrere Kinder unterschiedliche Breiten besitzen.
/// Aus diesem Grund bekommt ``Color/green`` eine explizite Breite von 100,
/// ``Color/blue`` eine Breite von 50 und
/// ``Color/purple`` eine Breite von 25:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         VStack(alignment: .leading, spacing: 0) {
///             Color.green.frame(width: 100)
///             Color.blue.frame(width: 50)
///             Color.purple.frame(width: 25)
///         }
///     }
/// }
/// ```
/// ![Vertikaler Stack mit Leading-Alignment.](VStackLeading.png)
public struct VStack<Content>: View where Content: View {
	let alignment: HorizontalAlignment
	let spacing: Double?
	let content: () -> Content
	
    /// Erstellt einen neuen VStack aus den übergebenen Inhalten.
    ///
    /// Die Kinder werden standardmäßig in der Mitte des VStacks ausgerichtet.
    /// Wenn kein Wert für `spacing` übergeben wird, wird der Standard verwendet.
    ///
    /// - Parameters:
    ///   - alignment: Horizontale ausrichtung der Kinder.
    ///   - spacing: Abstand der Kinder zueinander.
    ///   - content: Kinder des Stacks.
	public init(
		alignment: HorizontalAlignment = .center,
		spacing: Double? = nil,
        @ViewBuilder content: @escaping () -> Content)
	{
		self.alignment = alignment
		self.spacing = spacing
		self.content = content
	}
}

extension VStack: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
		let node = VStackNode(alignment: alignment, spacing: spacing)
		parent.add(child: node)
        content().unwrapped().buildTree(node)
    }
}
