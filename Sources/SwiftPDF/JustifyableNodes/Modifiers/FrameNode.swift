/// Ermöglicht das Angeben einer festen Größe.
///
/// Mit dieser Node ist es möglich eine feste Größe anzugeben.
/// Das wird dadurch erreicht, dass die Mindest- und Maximalgröße
/// die übergebene Größe bekommt, sodass es für das Layoutsystem
/// keinen weiteren Spielraum zur Entscheidung der Größe gibt.
/// Wenn allerdings kein Wert für die Breite oder Höhe angegeben wird,
/// wird dem Kind die Wahl der entsprechenden Größe überlassen.
///
/// Bei einem Kind, welches kleiner ist, als dieser Knoten,
/// kann das Kind durch einem `Alignment` ausgerichtet werden.
final class FrameNode: AlignmentNode {
    
    /// Feste Breite dieses Knotens. Bei `nil` nimmt diese Node die Breite des Kindes an.
	private let _width: Double?
    
    /// Feste Höhe dieses Knotens. Bei `nil` nimmt diese Node die Höhe des Kindes an.
	private let _height: Double?
    
    /// Ausrichtung des Kinder in dieser Node.
	private let alignment: Alignment
	
	init(width: Double?, height: Double?, alignment: Alignment) {
		self._width = width
		self._height = height
		self.alignment = alignment
	}
	
	override func justifyBounds() {
		if let child = children.first {
            child.justifyBounds()
            // Die Mindestgröße dieser Node entspricht der übergeben Größe,
            // falls definiert, ansonsten ist die Mindestgröße gleich der des Kindes.
			minWidth = _width ?? child.minWidth
			minHeight = _height ?? child.minHeight
			maxWidth = _width ?? child.maxWidth
			maxHeight = _height ?? child.maxHeight
		}
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let child = children.first {
            // Wenn keine feste Größe festgelegt wurde,
            // wird die vorgeschlagene Größe verwendet.
			let proposedChildWidth = self._width ?? proposedWidth
			let proposedChildHeight = self._height ?? proposedHeight
            // Die zuvor ermittelte Größe wird dem Kind als Vorschlag übergeben.
			child.justify(proposedWidth: proposedChildWidth, proposedHeight: proposedChildHeight)
            // Nachdem das Kind seine Größe gewählt hat, wird diese Größe zur eigenen.
			self.width = self._width ?? child.width
			self.height = self._height ?? child.height
		} else {
            // Wenn kein Kind existiert,
            // zum Beispiel bei Anwendung auf einer `EmptyView`,
            // wird die eigene Größe auf die übergebene Größe gesetzt.
            // Wenn keine Größe gewählt wurde,
            // soll diese Node keinen Platz verbrauchen.
			self.width = self._width ?? 0
			self.height = self._height ?? 0
		}
	}
    
    override func justify(x: Double) {
        self.x = x
        
        switch alignment.horizontal {
        case .leading:
            alignChildrenLeading()
            
        case .center:
            centerChildrenHorizontally()
            
        case .trailing:
            alignChildrenTrailing()
        }
    }
    
    override func justify(y: Double) {
        self.y = y
        
        switch alignment.vertical {
        case .top:
            alignChildrenTop()
            
        case .center:
            centerChildrenVertically()
            
        case .bottom:
            alignChildrenBottom()
        }
    }
}
