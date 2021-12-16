/// Eine Struktur, die Views mit Hilfe einer zugrundeliegenden Sammlung von Daten erstellt.
///
/// `ForEach` ist eine `View`, die über eine `Collection` oder eine `Range` iteriert.
/// Jede Iteration erzeugt eine neue `View`.
/// Die Struktur wird gewöhnlich in Stacks wie dem ``HStack``, ``VStack`` und ``ZStack`` verwendet.
///
/// Das folgende Beispiel erstellt mit Hilfe von `ForEach` jeweils einen neuen Tag,
/// der einen bestimmten Status repräsentiert.
///
/// ```swift
/// struct Status {
///     let name: String
///     let color: Color
/// }
///
/// struct ContentView: View {
///
///     let testStatus = [
///         Status(name: "Erfolgreich", color: .green),
///         Status(name: "Fehlgeschlagen", color: .orange),
///         Status(name: "Error", color: .red)
///     ]
///
///     var body: some View {
///         VStack(alignment: .leading) {
///             ForEach(testStatus) { status in
///                 Text(status.name)
///                     .padding()
///                     .background {
///                         RoundedRectangle(cornerRadius: 5)
///                             .fill(status.color.brightness(1.5))
///                         RoundedRectangle(cornerRadius: 5)
///                             .stroke(status.color)
///                     }
///             }
///         }
///     }
/// }
/// ```
/// ![Der Status "Erfolgreich", "Fehlgeschlagen" und "Error".](ForEach.png)
///
public struct ForEach<Data, Content>: View where Data: Sequence, Content: View {
    
    /// Source of truth.
    let data: Data
    
    /// Funktion, die aus einem Element einer Sequence eine neue View erstellt.
    let content: (Data.Element) -> Content
    
    /// Erstellt eine neue ForEach-Struktur mit der übergebenen Sequence.
    /// - Parameters:
    ///   - data: Daten-Sequence, über die itereriert wird.
    ///   - content: Funktion, die eine neue View für ein einzelnes Element der Daten-Sequence liefert.
    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
}

extension ForEach: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
        data.forEach { dataElement in
            content(dataElement).unwrapped().buildTree(parent)
        }
    }
}
