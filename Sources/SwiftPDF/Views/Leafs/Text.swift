/// Text-View, die eine oder mehrere Zeilen Text darstellt.
///
/// Wie es bei anderen Views der Fall ist,
/// versucht auch Text sich entsprechend seines Layouts anzupassen.
/// Wenn der darzustellende String nicht innerhalb einer Zeile passt, wird dieser unterteilt,
/// um über mehrere Zeilen dargestellt werden zu können.
///
/// Um explizite Zeilenumbrüche zu erzeugen,
/// können Zeilen mit einem `\n` abgeschlossen werden.
/// In diesem Beispiel wird ein Multiline-String verwendet,
/// der implizite `\n` vor dem Anfang einer neuen Zeile setzt:
/// ```swift
/// struct ContentView: View {
///
///     let multiline = """
///     Die Formatierung innerhalb
///     eines Multiline-Strings
///     wird auch bei einer
///     Text-View beibehalten.
///     """
///
///     var body: some View {
///         Text(multiline)
///     }
/// }
/// ```
/// ![Text mit mehreren Zeilen.](Text.png)
///
public struct Text: View {
	
    /// String-Wert des Textes.
	var content: String
	
    /// Modifikatoren, die auf den Text angewendet werden sollen.
	var modifiers: [Modifier] = []
    
	init(_ content: String, modifiers: [Modifier]) {
		self.content = content
		self.modifiers = modifiers
	}
	
    /// Erstellt ein neues Text-Objek, welches einen `String` darstellt.
    /// - Parameters:
    ///   - content: Der String-Wert, der dargestellt werden soll.
	public init<S>(_ content: S) where S: StringProtocol {
		self.content = String(content)
	}
}

extension Text {
	enum Modifier {
		case color(Color)
		case font(Font?)
		case fontSize(Double)
		case lineSpacing(Double)
	}
}

public extension Text {
    
    /// Setzt die Farbe des Textes.
    ///
    /// - Parameter color: Die Farbe, die verwendet werden soll, wenn der Text dargestellt wird.
    /// Bei `nil` erhält der Text die standard Füllfarbe.
	func foregroundColor(_ color: Color?) -> Text {
		textWithModifier(.color(color ?? .black))
	}
	
    /// Setzt die Schriftart des Textes.
    /// - Parameter font: Schriftart des neuen Textes.
	func font(_ font: Font?) -> Text {
		textWithModifier(.font(font))
	}
	
    /// Setzt die Schriftgröße des Textes.
    /// - Parameter size: Schriftgröße des neuen Textes.
    /// - Returns: Ein Text, mit der übergebenen Schriftgröße.
	func fontSize(_ size: Double) -> Text {
		textWithModifier(.fontSize(size))
	}
	
    /// Setzt die Größe des Zwischenraumes zwischen Zeilen eines Textes.
    /// - Parameter spacing: Der Abstand zwischen dem unteren Ende einer Zeile und dem oberen Ende der nächsten Zeile.
	func lineSpacing(_ spacing: Double) -> Text {
		textWithModifier(.lineSpacing(spacing))
	}
	
    /// Fügt einen neuen Modifikator zum Text hinzu.
    /// - Parameter modifier: Modifikator der dem Text hinzugefügt werden soll.
    /// - Returns: Neuer Text mit den Eigenschaften des vorherigen Textes und der neuen Eigenschaft.
	private func textWithModifier(_ modifier: Modifier) -> Text {
		let modifiers = self.modifiers + [modifier]
		return Text(content, modifiers: modifiers)
	}
}

extension Text: PrimitiveView {
	func buildTree(_ parent: JustifiableNode) {
		let drawable = TextDrawable(content: content, modifiers: modifiers)
		parent.add(child: drawable)
	}
}
