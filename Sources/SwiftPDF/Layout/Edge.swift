/// Aufzählung von Kanten eines Rechtecks.
public enum Edge: Int8, CaseIterable {
	case top, leading, bottom, trailing
	
    /// Eine Zusammenstellung von Kanten eines Rechtecks.
	public struct Set: OptionSet {
        
		public let rawValue: Int8
		
		public init(rawValue: Int8) {
			self.rawValue = rawValue
		}
		
        /// Obere Kante eines Rechtecks.
		public static let top: Edge.Set = .init(rawValue: 1 << Edge.top.rawValue)
        
        /// Linke Kante eines Rechtecks.
		public static let leading: Edge.Set = .init(rawValue: 1 << Edge.leading.rawValue)
        
        /// Untere Kante eines Rechtecks.
		public static let bottom: Edge.Set = .init(rawValue: 1 << Edge.bottom.rawValue)
        
        /// Rechte Kante eines Rechtecks.
		public static let trailing: Edge.Set = .init(rawValue: 1 << Edge.trailing.rawValue)
		
        /// Alle Kanten eines Rechtecks.
        ///
        /// Enthält ``Edge/Set/top``, ``Edge/Set/leading``,
        /// ``Edge/Set/bottom`` und ``Edge/Set/trailing``.
		public static let all: Edge.Set = [.top, .leading, .bottom, .trailing]
        
        /// Kanten auf der horizontalen Achse eines Rechtecks.
        ///
        /// Enthält``Edge/Set/leading`` und  ``Edge/Set/trailing``.
		public static let horizontal: Edge.Set = [.leading, .trailing]
        
        /// Kanten auf der vertikalen Achse eines Rechtecks.
        ///
        /// Enthält ``Edge/Set/top`` und  ``Edge/Set/bottom``.
		public static let vertical: Edge.Set = [.top, .bottom]
		
        /// Erstellt ein `Set` mit einer Kante.
        /// - Parameter edge: Kante des Rechtecks.
		public init(_ edge: Edge) {
			self.rawValue = 1 << edge.rawValue
		}
	}
}
