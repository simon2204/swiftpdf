/// Ein flexibler Raum, der sich entlang der Hauptachse audehnt.
///
/// Ein `Spacer` nimmt soviel Raum ein, wie er bekommt.
/// Wenn zum Beispiel ein Spacer in einem HStack platziert wird,
/// dehnt er sich horizontal so weit aus, wie es der Stack zulässt
/// und schiebt dabei Geschwister-Views aus dem Weg,
/// innerhalb der Grenzen der Stackgröße.
///
public struct Spacer: View {
	
    /// Mindest Länge des Spacer, die nicht unterschritten werden soll.
	var minLength: Double?
	
    /// Erstellt einen neuen Spacer mit einem standard Zwischenraum.
	public init() {}
	
    /// Erstellt einen neuen Spacer mit einer übergebenen mindest Länge.
    ///
    /// Bei `nil` wird der Standardwert für Zwischenräume verwendet.
    ///
    /// - Parameter minLength: Größe des Spacer, die er nicht unterschreiten soll.
	public init(minLength: Double?) {
		self.minLength = minLength
    }
}

extension Spacer: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let node = SpacerNode(minLength: minLength)
        parent.add(child: node)
	}
}
