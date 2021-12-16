/// Ein Typ, der `ViewModifier` definiert, um `View`s zusätzliche Eigenschaften zu geben.
///
/// Modifikatoren umschließen `View`s innerhalb einer neuen `View`,
/// die zusätzliche Eigenschaften beinhalten kann,
/// um zum Beispiel eine `View` mit einer festen Breite und Höhe zu erzeugen.
///
/// `SwiftPDF` definiert standard Modifikatoren, die auf `View`s angewandt werden können,
/// wie zum Beispiel ``View/padding(_:)-4nkjg`` oder ``View/frame(width:height:alignment:)``
/// und weiteren Modifikatoren die in ``View`` aufgelistet sind.
///
/// Eigene `ViewModifier` können erstellt werden,
/// durch deklarieren eines Typs, der dem `ViewModifier`-Protokoll entspricht.
/// Dazu muss die `body` Funktion implementiert werden,
/// um die zusätzlichen Eigenschaften auf einer `View` anwenden zu können.
/// Um den erstellten `ViewModifier` zu verwenden, wird der Modifikator der Funktion
/// ``View/modifier(_:)`` übergeben.
///
/// In diesem Beispiel wird ein `TagModifier` erstellt, um aus einer beliebigen `View`
/// einen Tag, mit einer bestimmten Farbe zu erstellen:
/// ```swift
/// struct TagModifier: ViewModifier {
///
///     let color: Color
///
///     func body(content: Content) -> some View {
///         content
///             .background {
///                 GeometryReader { frame in
///                     ZStack {
///                         RoundedRectangle(cornerRadius: frame.height / 4)
///                             .fill(color.brightness(1.5))
///                         RoundedRectangle(cornerRadius: frame.height / 4)
///                             .stroke(color)
///                     }
///                 }
///         }
///     }
/// }
///
/// struct ContentView: View {
///     var body: some View {
///         VStack {
///             Text("Rotes Tag")
///                 .modifier(TagModifier(color: .red))
///
///             Text("Grünes Tag mit Padding.")
///                 .padding(.vertical, 4)
///                 .modifier(TagModifier(color: .green))
///
///             Circle()
///                 .fill(.pink)
///                 .frame(width: 20, height: 20)
///                 .padding(.horizontal, 10)
///                 .padding(.vertical, 5)
///                 .modifier(TagModifier(color: .blue))
///         }
///     }
/// }
/// ```
/// ![Modifikator auf zwei Texten und einer Form angewendet.](Modifier.png)
///
/// Um den `TagModifier` einfacher verwenden zu können,
/// erweitern wir das `View`-Protokoll mit der Funktion `tag(color:)`:
/// ```swift
/// extension View {
///     func tag(color: Color) -> some View {
///         self.modifier(TagModifier(color: color))
///     }
/// }
///
/// struct ContentView: View {
///     var body: some View {
///         VStack {
///             Text("Rotes Tag")
///                 .tag(color: .red)
///
///             Text("Grünes Tag mit Padding.")
///                 .padding(.vertical, 4)
///                 .tag(color: .green)
///
///             Circle()
///                 .fill(.pink)
///                 .frame(width: 20, height: 20)
///                 .padding(.horizontal, 10)
///                 .padding(.vertical, 5)
///                 .tag(color: .blue)
///         }
///     }
/// }
/// ```
///
public protocol ViewModifier {
	associatedtype Body: View
	typealias Content = _ViewModifier_Content
	func body(content: Content) -> Self.Body
}

@_spi(SwiftPDF)
extension ViewModifier where Body == Never {
	public func body(content: Content) -> Body {
		fatalError()
	}
}

public extension View {
	func modifier<Modifier>(_ modifier: Modifier) -> ModifiedContent<Self, Modifier> {
        ModifiedContent(content: self, modifier: modifier)
	}
}
