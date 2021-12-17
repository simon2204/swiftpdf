/// Sorgt für ein Padding um einer Node.
///
/// Damit ein Kind die richtige Breite zugewiesen bekommt, sodass es
/// zu den Rändern einen gewissen Abstand bekommt,
/// wird dem Kind die Breite vorgeschlagen,
/// die auch dieser Knoten vorgeschlagen bekommt,
/// aber ohne den Wert des horizontalen Paddings.
///
/// Die eigene Breite besteht aus der Breite des Kindes und dem Wert des horizontalen Paddings,
/// sowie die Höhe aus der Höhe des Kindes und dem Wert des vertikalen Paddings besteht.
final class PaddingNode: JustifiableNode {
	
	private let insets: EdgeInsets
	
    /// Padding auf der horizontalen Achse,
    /// zusammengesetzt aus dem `leading`- und `trailing`-Padding.
	private var horizontalPadding: Double {
		insets.leading + insets.trailing
	}
	
    /// Padding auf der vertikalen Achse,
    /// zusammengesetzt aus dem `top`- und `bottom`-Padding.
	private var verticalPadding: Double {
		insets.top + insets.bottom
	}
	
    /// Erstellt eine PaddingNode mit bestimmten Einrückungstiefen.
    /// - Parameter insets: Einrückungstiefe dieser Node. Bei `nil` wird eine standard Einrückungstiefe verwendet.
	init(insets: EdgeInsets?) {
		self.insets = insets ?? EdgeInsets(all: Default.spacing)
		super.init()
    }
	
	override func justifyBounds() {
        
        // Mindestbreite besteht aus dem `horizontalPadding`
        // und aus der Mindestbreite des Kindes.
		minWidth = horizontalPadding
        
        // Mindesthöhe besteht aus dem `verticalPadding`
        // und aus der Mindesthöhe des Kindes.
		minHeight = verticalPadding
        
        // Maximalbreite besteht aus dem `horizontalPadding`
        // und aus der Maximalbreite des Kindes.
		maxWidth = horizontalPadding
        
        // Maximalhöhe besteht aus dem `verticalPadding`
        // und aus der Maximalhöhe des Kindes.
		maxHeight = verticalPadding
		
		if let child = children.first {
			child.justifyBounds()
			minWidth += child.minWidth
			minHeight += child.minWidth
			maxWidth += child.maxWidth
			maxHeight += child.maxHeight
		}
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let child = children.first {
            
            // Das Kind bekommt die Breite vorgeschlagen, die übrig bleibt,
            // wenn das horizontale Padding subtrahiert wurde.
			let childWidth = proposedWidth - horizontalPadding
            
            // Das Kind bekommt die Höhe vorgeschlagen, die übrig bleibt,
            // wenn das vertikale Padding subtrahiert wurde.
			let childHeight = proposedHeight - verticalPadding
			
			child.justify(proposedWidth: childWidth, proposedHeight: childHeight)
			
            // Die Breite dieses Knotens besteht aus der Breite
            // des Kindes plus der Breite des horizontalen Paddings.
			self.width = child.width + horizontalPadding
            
            // Die Höhe dieses Knotens besteht aus der Höhe
            // des Kindes plus der Breite des vertikalen Paddings.
			self.height = child.height + verticalPadding
		}
	}
	
	override func justify(x: Double) {
		self.x = x
        
        // Die x-Position des Kindes verschiebt sich um den Wert des `leading`-Paddings.
		children.first?.justify(x: x + insets.leading)
	}
	
	override func justify(y: Double) {
		self.y = y
        
        // Die y-Position des Kindes verschiebt sich um den Wert des `bottom`-Paddings.
		children.first?.justify(y: y + insets.bottom)
	}
}
