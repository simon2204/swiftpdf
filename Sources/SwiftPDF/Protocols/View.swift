/// Ein Typ, der einen Teil des Erscheinungsbildes einer PDF definiert und Modifikatoren bereitstellt,
/// die zur Konfiguration von Views verwenden können.
///
/// Benutzerdefinierte Views können erstellt werden,
/// durch deklarieren eines Typs, der dem `View`-Protokoll entspricht.
/// Dazu muss die `body` Eigenschaft implementiert werden,
/// um den Inhalt für die benutzerdefinierte `View` bereitzustellen.
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         Text("Hallo, Welt!")
///     }
/// }
/// ```
///
/// Durch vordefinierte ``View``s, wie im Beispiel zuvor mit ``Text``
/// und weiteren selbstdefinierten `View`s,
/// können hierarchisch PDF-Dokumente erstellt werden.
///
/// Das ``View``-Protokoll beinhaltet vordefinierte Modifikatoren,
/// die angewendet werden können. Dabei wird die `View`,
/// auf die der Modifikator angewendet wird, in eine weitere View gepackt,
/// die bestimmte Eigenschaften besitzt.
/// Wie zum Beispiel  ``View/border(color:width:)``,
/// welche eine Umrandung, mit einer bestimmten Farbe und Breite zieht:
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         Text("Hallo, Welt!")
///             .border(color: .green, width: 1)
///     }
/// }
/// ```
public protocol View {
    associatedtype Body: View
    var body: Body { get }
}

@_spi(SwiftPDF)
extension View where Body == Never {
	public var body: Never {
		fatalError()
	}
}

extension View {
    /// Entpackt eine `View`, um die zugrundeliegende `PrimitiveView` zu erhalten.
    ///
    /// `View`s können aus mehreren `Views` zusammengesetzt und verschachtelt sein.
    /// Zugrunde liegt aber immer eine `PrimitiveView`.
    /// Da jede `View` einen `body`-Property besitzt,
    /// im Gegensatz zu einer `PrimitiveView`, wird dort hineingeschaut, ob sich darin
    /// eine `PrimitiveView` befindet. Wenn die `body`-Property keine
    /// `PrimitiveView` enthält, bedeutet es, dass `body` eine `View` liefert und
    /// in dieser wieder nach einer `PrimitiveView` geschaut wird, und so weiter,
    /// bis eine `PrimitiveView` gefunden wurde.
    ///
    /// - Returns: Liefert eine `PrimitiveView` aus einer hierachischen Struktur von Views.
    func unwrapped() -> PrimitiveView {
        // Wenn die `View` selbst als `PrimitiveView` gecastet
        // werden kann, wird die `PrimitiveView` zurück geliefert.
        if let primitive = self as? PrimitiveView {
            return primitive
        }
        // Liefert eine `PrimitiveView` aus dem `body` dieser `View`.
        return self.body.unwrapped()
    }
}
