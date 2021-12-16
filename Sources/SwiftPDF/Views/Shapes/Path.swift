/// Der Umriss einer 2D-Form.
public struct Path {
	
    /// Segmente, die den Pfad ergeben.
	var segments: [Segment] = []
	
    /// Aufzählung der verschiedenen Segmente eines Pfads.
	enum Segment: Equatable {
		case move(to: Point)
		case line(to: Point)
		case lines(between: [Point])
		case rect(Rect)
		case ellipse(in: Rect)
		case curve(to: Point, control1: Point, control2: Point)
		case closeSubpath
	}
	
    /// Erstellt einen leeren Pfad.
	public init() {}
	
    /// Erzeugt einen leeren Pfad und führt dann die `Closure` aus, um die ersten Elemente hinzuzufügen.
	public init(_ callback: (inout Path) -> ()) {
		var base = Path()
		callback(&base)
		self = base
	}
	
	/// Beginnt einen neuen Unterpfad an dem angegebenen Punkt.
	///
	/// Der angegebene Punkt wird zum Startpunkt eines neuen Unterpfads.
    /// Der aktuelle Punkt wird auf diesen Startpunkt gesetzt.
	///
	/// - Parameter point: Der Punkt, an dem ein neuer Unterpfad beginnen soll.
	public mutating func move(to point: Point) {
		segments.append(.move(to: point))
	}
	
	/// Hängt ein gerades Liniensegment vom aktuellen Punkt zum angegebenen Punkt an.
	///
	/// Nach dem Hinzufügen des Liniensegments wird der aktuelle Punkt
    /// auf den Endpunkt des Liniensegments gesetzt.
	///
	/// - Parameter point: Die Position für das Ende des neuen Liniensegments.
	public mutating func addLine(to point: Point) {
		segments.append(.line(to: point))
	}
	
	/// Fügt dem aktuellen Pfad eine Folge von miteinander verbundenen geradlinigen Segmenten hinzu.
	///
	/// Der Aufruf dieser Convenience-Methode ist gleichbedeutend
    /// mit dem Aufruf der Methode ``move(to:)`` mit dem ersten Wert im Points-Array
    /// und dem anschließenden Aufruf der Methode ``addLine(to:)``
    /// für jeden weiteren Punkt, bis das Array erschöpft ist.
    /// Nach dem Aufruf dieser Methode ist der aktuelle Punkt des Pfades der letzte Punkt im Array.
    ///
	/// - Parameter points: Ein Array von Werten, die die Start- und Endpunkte
    /// der zu zeichnenden Liniensegmente angeben. Der erste Punkt im Array gibt den Anfangsstartpunkt an.
	public mutating func addLines(between points: [Point]) {
		segments.append(.lines(between: points))
	}
	
	/// Fügt einen rechteckigen Pfad zum aktuellen Pfad hinzu.
	///
	/// Fügt ein Rechteck zu einem Pfad hinzufügt,
    /// indem die Funktion mit der linken unteren Ecke beginnt und dann Linien gegen den Uhrzeigersinn hinzufügt,
    /// um ein Rechteck zu erstellen.
    ///
	/// - Parameter rect: Ein Rechteck.
	public mutating func addRect(_ rect: Rect) {
		segments.append(.rect(rect))
	}
	
	/// Fügt eine Reihe von rechteckigen Pfaden zum aktuellen Pfad hinzu.
	///
	/// Der Aufruf dieser Convenience-Methode ist gleichbedeutend mit dem
    /// wiederholten Aufruf der Methode ``addRect(_:)`` für jedes Rechteck im Array.
	///
	/// - Parameter rects: Ein Array von Rechtecken.
	public mutating func addRects(_ rects: [Rect]) {
		rects.forEach { rect in
			addRect(rect)
		}
	}
	
	/// Fügt dem aktuellen Pfad eine kubische Bézier-Kurve mit dem angegebenen Endpunkt und den Kontrollpunkten hinzu.
	///
	/// Diese Methode konstruiert eine Kurve,
    /// die am aktuellen Punkt des Pfades beginnt und am angegebenen Endpunkt endet,
    /// wobei die Krümmung durch die beiden Kontrollpunkte definiert wird.
    /// Nachdem diese Methode diese Kurve an den aktuellen Pfad angehängt hat,
    /// wird der Endpunkt der Kurve zum aktuellen Punkt des Pfades.
	///
	/// - Parameters:
	///   - end: Der Punkt, an dem die Kurve enden soll.
	///   - control1: Der erste Kontrollpunkt der Kurve.
	///   - control2: Der zweite Kontrollpunkt der Kurve.
	public mutating func addCurve(to end: Point, control1: Point, control2: Point) {
		segments.append(.curve(to: end, control1: control1, control2: control2))
	}
	
	/// Fügt dem aktuellen Pfad eine quadratische Bézier-Kurve
    /// mit dem angegebenen Endpunkt und Kontrollpunkt hinzu.
	///
	/// Diese Methode konstruiert eine Kurve,
    /// die am aktuellen Punkt des Pfades beginnt und am angegebenen Endpunkt endet,
    /// wobei die Krümmung durch den Kontrollpunkt definiert wird.
    /// Nachdem diese Methode diese Kurve an den aktuellen Pfad angehängt hat,
    /// wird der Endpunkt der Kurve zum aktuellen Punkt des Pfades.
	///
	/// - Parameters:
	///   - end: Der Punkt, an dem die Kurve enden soll.
	///   - control: Der Kontrollpunkt der Kurve.
	public mutating func addQuadCurve(to end: Point, control: Point) {
		addCurve(to: end, control1: control, control2: control)
	}
	
	/// Fügt eine Ellipse hinzu, die in das angegebene Rechteck passt.
	///
	/// Die Ellipse wird durch eine Folge von Bézier-Kurven approximiert.
    /// Ihr Mittelpunkt ist der Mittelpunkt des Rechtecks,
    /// das durch den Parameter `rect` definiert ist.
    /// Ist das Rechteck quadratisch, so ist die Ellipse kreisförmig mit einem Radius,
    /// der der Hälfte der Breite (oder Höhe) des Rechtecks entspricht.
    /// Ist der Parameter `rect` rechteckig,
    /// so werden die Haupt- und Nebenachsen der Ellipse
    /// durch die Breite und Höhe des Rechtecks definiert.
    ///
	/// - Parameter rect: Ein Rechteck, das den Bereich definiert, in den die Ellipse passen soll.
	public mutating func addEllipse(in rect: Rect) {
		segments.append(.ellipse(in: rect))
	}
	
	/// Schließt den Unterpfad des aktuellen Pfades.
	///
	/// Hängt eine Linie vom aktuellen Punkt zum Startpunkt
    /// des aktuellen Unterpfades an und beendet den Unterpfad.
	public mutating func closePath() {
		segments.append(.closeSubpath)
	}
}

extension Path {
    /// Begrenzungsrechteck des Pfades.
    ///
    /// Das kleinstmögliche Rechteck,
    /// welches um den Pfad erstellt werden kann,
    /// welcher alle Segmente des Pfades beinhaltet.
	var boundingRect: Rect {
		let points = segments.flatMap { element -> [Point] in
			switch element {
			case .move(let point):
				return [point]
				
			case .line(let point):
				return [point]
				
			case .lines(let points):
				return points
				
			case .rect(let rect):
				return [rect.origin, Point(x: rect.maxX, y: rect.maxY)]
				
			case .ellipse(let rect):
				return [rect.origin, Point(x: rect.maxX, y: rect.maxY)]
				
			case .curve(let point, _, _):
				return [point]
				
			case .closeSubpath:
				break
			}
			
			return []
		}
		
		let xPositions = points.map(\.x)
		let yPositions = points.map(\.y)
		
		let minX = xPositions.min() ?? 0
		let maxX = xPositions.max() ?? 0
		
		let minY = yPositions.min() ?? 0
		let maxY = yPositions.max() ?? 0
		
		let origin = Point(x: minX, y: minY)
		
		let width = maxX - minX
		let height = maxY - minY
		
		let size = Size(width: width, height: height)
		
		return Rect(origin: origin, size: size)
	}
}

extension Path: Shape {
	public func path(in rect: Rect) -> Path {
		self
	}
}

extension Path {
	public var body: some View {
        ShapeView(shape: self, style: .fill, color: .black)
	}
}
