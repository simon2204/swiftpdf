/// Eine View, die keinen Inhalt hat.
///
/// EmptyViews werden in Situationen eingesetzt,
/// in denen ein View-Typ ein oder mehrere Child-Views als Parameter erlaubt,
/// aber an der entsprechenden Stelle keine View dargestellt werden soll.
///
/// Zum Beispiel wird im Folgenden `EmptyView` verwendet, damit der `HorizontalDivider`
/// keine View einfügt, die zum Beispiel eine Überschrift für einen neuen Abschnitt beschreibt.
///
/// ```swift
/// struct HorizontalDivider<Description>: View where Description: View {
///
///     let description: Description
///
///     let thickness: Double = 1
///
///     let lineColor: Color = .blue
///
///     var body: some View {
///         HStack(spacing: 0) {
///             lineColor
///                 .frame(height: thickness)
///
///             description
///                 .padding(.horizontal)
///
///             lineColor
///                 .frame(height: thickness)
///         }
///     }
/// }
///
/// struct ContentView: View {
///     var body: some View {
///         VStack {
///             HorizontalDivider(description: EmptyView())
///             HorizontalDivider(description: Text("Hallo, Welt!"))
///             HorizontalDivider(
///                 description: Circle()
///                     .fill(.blue)
///                     .frame(width: 25, height: 25)
///             )
///         }
///     }
/// }
/// ```
/// ![Eine horizontale Linie, ohne einer beschreibenden View, mit einem Text und einem Symbol.](EmptyView.png)
public struct EmptyView: View {
    /// Erstellt eine neue View, ohne Inhalt.
    public init() {}
}

extension EmptyView: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {}
}
