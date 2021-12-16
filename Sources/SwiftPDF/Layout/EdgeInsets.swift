/// Einrückungstiefe der Seiten eines Rechtecks.
public struct EdgeInsets: Equatable {
    
    /// Einrückungstiefe der oberen Seiten eines Rechtecks.
	public var top: Double
    
    /// Einrückungstiefe der linken Seiten eines Rechtecks.
	public var leading: Double
    
    /// Einrückungstiefe der unteren Seiten eines Rechtecks.
	public var bottom: Double
    
    /// Einrückungstiefe der rechten Seiten eines Rechtecks.
	public var trailing: Double
    
    /// Initialisiert ein Objekt, bei der jede Seite eine eigene Einrückungstiefe bekommt.
    /// - Parameters:
    ///   - top: Einrückungstiefe der oberen Seiten eines Rechtecks.
    ///   - leading: Einrückungstiefe der linken Seiten eines Rechtecks.
    ///   - bottom: Einrückungstiefe der unteren Seiten eines Rechtecks.
    ///   - trailing: Einrückungstiefe der rechten Seiten eines Rechtecks.
	public init(top: Double, leading: Double, bottom: Double, trailing: Double) {
		self.top = top
		self.leading = leading
		self.bottom = bottom
		self.trailing = trailing
	}
	
    /// Initialisiert ein Objekt ohne Einrückungstiefe.
	public init() {
		self.init(top: 0, leading: 0, bottom: 0, trailing: 0)
	}
}

extension EdgeInsets {
    /// Initialisiert ein Objekt, bei der jede Seite die gleiche Einrückungstiefe erhält.
    /// - Parameter all: Einrückungstiefe aller Seiten eines Rechtecks.
	init(all: Double) {
		self.init(top: all, leading: all, bottom: all, trailing: all)
	}
}
