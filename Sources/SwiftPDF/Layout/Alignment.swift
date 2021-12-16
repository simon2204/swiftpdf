/// Ausrichtung auf der horizontalen und vertikalen Achse.
///
/// Beschreibt, wie Objekte an der horizontalen und vertikalen Achse ausgerichtet werden sollen.
public struct Alignment {
    
    /// Ausrichtung an der horizontalen Achse.
	var horizontal: HorizontalAlignment
    
    /// Ausrichtung an der vertikalen Achse.
	var vertical: VerticalAlignment
	
    /// Erstellt ein neues `Alignment`-Objekt mit Angabe über die Ausrichtung an der horizontalen und vertikalen Achse.
    /// - Parameters:
    ///   - horizontal: Ausrichtung an der horizontalen Achse.
    ///   - vertical: Ausrichtung an der vertikalen Achse.
	public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
		self.horizontal = horizontal
		self.vertical = vertical
	}
	
    /// Ausrichtung in der Mitte der horizontalen Achse und in der Mitte der vertikalen Achse.
	public static let center = Alignment(horizontal: .center, vertical: .center)

    /// Ausrichtung an der linken Seite der horizontalen Achse und in der Mitte der vertikalen Achse.
	public static let leading = Alignment(horizontal: .leading, vertical: .center)
	
    /// Ausrichtung an der rechten Seite der horizontalen Achse und in der Mitte der vertikalen Achse.
	public static let trailing = Alignment(horizontal: .trailing, vertical: .center)
	
    /// Ausrichtung an der oberen Seite der vertikalen Achse und in der Mitte der horizontalen Achse.
	public static let top = Alignment(horizontal: .center, vertical: .top)
	
    /// Ausrichtung an der unteren Seite der vertikalen Achse und in der Mitte der horizontalen Achse.
	public static let bottom = Alignment(horizontal: .center, vertical: .bottom)
	
    /// Ausrichtung an der linken Seite der horizontalen Achse und an der oberen Seite der vertikalen Achse.
	public static let topLeading = Alignment(horizontal: .leading, vertical: .top)
	
    /// Ausrichtung an der rechten Seite der horizontalen Achse und an der oberen Seite der vertikalen Achse.
	public static let topTrailing = Alignment(horizontal: .trailing, vertical: .top)
	
    /// Ausrichtung an der linken Seite der horizontalen Achse und an der unteren Seite der vertikalen Achse.
	public static let bottomLeading = Alignment(horizontal: .leading, vertical: .bottom)
	
    /// Ausrichtung an der rechten Seite der horizontalen Achse und an der unteren Seite der vertikalen Achse.
	public static let bottomTrailing = Alignment(horizontal: .trailing, vertical: .bottom)
}

/// Ausrichtungsmöglichkeiten auf der horizontalen Achse.
public enum HorizontalAlignment {
    /// Ausrichtung an der linken Seite der horizontalen Achse.
	case leading
    /// Ausrichtung in der Mitte der horizontalen Achse.
	case center
    /// Ausrichtung an der rechten Seite der horizontalen Achse.
	case trailing
}

/// Ausrichtungsmöglichkeiten auf der vertikalen Achse.
public enum VerticalAlignment {
    /// Ausrichtung an der oberen Seite der vertikalen Achse.
	case top
    /// Ausrichtung in der Mitte der vertikalen Achse.
	case center
    /// Ausrichtung an der unteren Seite der vertikalen Achse.
	case bottom
}
