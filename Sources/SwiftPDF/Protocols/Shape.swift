/// Ein Typ, um 2D Formen zu erstellen.
///
/// Benutzerdefinierte Shapes können erstellt werden,
/// durch deklarieren eines Typs, der dem `Shape`-Protokoll entspricht.
/// Dazu muss die ``Shape/path(in:)`` Funktion implementiert werden,
/// um den ``Path`` für die entsprechende Form  zu liefern.
///
/// Auf `Shape`s können die Methoden ``Shape/fill(_:)`` und
/// ``Shape/stroke(_:lineWidth:)`` angewendet werden,
/// um die Form mit einer Farbe zu füllen oder
/// um den Pfad der Form, mit einer Farbe und Breite der Linie, zu zeichnen.
/// Wenn weder ``Shape/fill(_:)`` noch ``Shape/stroke(_:lineWidth:)``
/// verwendet werden, wird die Form mit ``Color/black`` gefüllt.
///
/// In diesem Beispiel wird eine Stern-Form erstellt,
/// der eine Anzahl an Zacken übergeben werden kann:
/// ```swift
/// struct Star: Shape {
///
///     /// Anzahl der Zacken.
///     var points = 5
///
///     func path(in rect: Rect) -> Path {
///
///         // Länge bis zur Spitze einer Zacke,
///         // beginnend von der Mitte des Sterns.
///         let outerRadius = min(rect.width, rect.height) / 2
///
///         // Länge bis zum Tal zwischen zweier Zacken,
///         // beginnend von der Mitte des Sterns.
///         let innerRadius = outerRadius / 2.25
///
///         // Mitte des Sterns.
///         let center = Point(x: rect.midX, y: rect.midY)
///
///         // Winkel des Tals, senkrecht unter der Mitte.
///         let startAngle = -Double.pi / 2 // -90°
///         let endAngle = 3 * Double.pi / 2 // 270°
///
///         // Winkel zwischen der Spitze und dem Anfang einer Zacke eines Sterns.
///         let halfCornerAngle = Double.pi / Double(points)
///
///         // Winkel zwischen zwei Zacken eines Sterns.
///         let cornerAngle = halfCornerAngle * 2
///
///         // Winkel der Täler zwischen den Zacken.
///         let innerAngles = stride(
///             from: startAngle,
///             through: endAngle,
///             by: cornerAngle)
///
///         // Alle Punkte der Täler und Spitzen.
///         let points = innerAngles.lazy.flatMap { angle -> [Point] in
///             let innerX = center.x + innerRadius * cos(angle)
///             let innerY = center.y + innerRadius * sin(angle)
///             let outerX = center.x + outerRadius * cos(angle + halfCornerAngle)
///             let outerY = center.y + outerRadius * sin(angle + halfCornerAngle)
///             return [Point(x: innerX, y: innerY), Point(x: outerX, y: outerY)]
///         }
///
///         // Pfad des Sterns.
///         var path = Path()
///
///         // Iterator über Punkte des Sterns.
///         var pointIterator = points.makeIterator()
///
///         // Zeichnet den Stern.
///         if let firstPoint = pointIterator.next() {
///             path.move(to: firstPoint)
///             while let nextPoint = pointIterator.next() {
///                 path.addLine(to: nextPoint)
///             }
///         }
///
///         path.closePath()
///
///         return path
///     }
/// }
/// ```
///
/// Da `Shape` auch eine ``View`` ist, können die Methoden einer `View`
/// auch auf die eines `Shape`s angewendet werden.
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         HStack {
///             Star()
///                 .fill(.yellow)
///                 .frame(width: 300, height: 300)
///                 .padding(5)
///                 .border(color: .purple, width: 5)
///
///             Star(points: 6)
///                 .stroke(.blue)
///                 .frame(width: 300, height: 300)
///                 .padding(5)
///                 .border(color: .red, width: 5)
///         }
///     }
/// }
/// ```
/// ![Ein gelber Stern und ein Stern mit einem blauen Pfad.](Shape.png)
///
/// Um einen `Shape` eine Füllung und eine Umrandung zu geben,
/// müssen zwei mal die gleichen `Shape`s erstellt werden,
/// wobei das erste `Shape` ausgefüllt wird und um das andere
/// wird der Pfad gezeichnet. Durch einen ``ZStack`` werden
/// die beiden Objekte dann so positioniert, dass das Objekt mit der Füllung
/// hinter dem anderen liegt.
///
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         ZStack {
///             Star()
///                 .fill(.yellow)
///             Star()
///                 .stroke(.orange, lineWidth: 5)
///         }
///         .frame(width: 300, height: 300)
///     }
/// }
/// ```
/// ![Gelber Stern, mit einer orangefarbenen Umrandung.](Shape2.png)
public protocol Shape: View {
    /// Liefert den Pfad dieses `Shape`s innerhalb eines Bereiches.
    /// - Parameter rect: Der Rahmen dieses `Shape`s.
    /// Gibt einen freien Bereich an, in dem der Pfad definiert werden soll.
	func path(in rect: Rect) -> Path
}

extension Shape {
	public var body: some View {
		ShapeView(shape: self, style: .fill, color: .black)
	}
}

public extension Shape {
    /// Füllt dieses `Shape` mit einer Farbe aus.
    /// - Parameter color: Farbe, die dieses `Shape` bekommen soll.
	func fill(_ color: Color) -> some View {
		ShapeView(shape: self, style: .fill, color: color)
	}
    
    /// Zeichnet eine Linie entlang des Pfades dieses `Shape`s.
    /// - Parameters:
    ///   - color: Farbe der Umrandung.
    ///   - lineWidth: Breite der Umrandung.
	func stroke(_ color: Color, lineWidth: Double = 1) -> some View {
		ShapeView(shape: self, style: .stroke(width: lineWidth), color: color)
	}
}
