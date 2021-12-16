/// Definiert eine `View` ohne die `body`-Property.
///
/// Primitive Views sind `View`s, die keinen `body` besitzen.
/// Anders als bei "normalen" `View`s, bestehen sie nicht
/// aus weiteren zusammengesetzten `View`s.
/// Sie sind die Grundelemente weiterer, selbstdefinierter `View`s.
///
/// `PrimitiveView`s bauen eine Baumstruktur von `JustifiableNode`s auf.
/// Um die Baumstruktur aufzubauen, müssen Typen, die das `PrimitiveView`-Protokoll
/// implementieren die buildTree(parent: JustifiableNode) Funktion definieren.
///
/// Diese Baumstruktur wird dafür verwendet,
/// die `View`s zu positionieren und zu dimensionieren
/// und anschließend entsprechend zu zeichnen.
protocol PrimitiveView {
    /// Fügt einen neuen Knoten zum Baum hinzu.
    /// - Parameter parent: Der Elternknoten des neuen Knotens.
    func buildTree(_ parent: JustifiableNode)
}
