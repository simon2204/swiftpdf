/// Richtet eine `Node` im Hintergrund einer anderen `Node`, mit einem entsprechenden `Alignment` aus.
///
/// Dieser Knoten übernimmt die Begrenzungen und Größe des Vordergrundes.
/// Nachdem die Größe des Vordergrundes bestimmt wurde,
/// wird diese Größe dem Hintergrund als Vorschlag gegeben,
/// um sich innerhalb dieser Größe entsprechend zu Dimensionieren.
/// Der Hintergrund kann also nur maximal so Groß sein,
/// wie der Vordergrund selbst,
/// sofern der Hintergrund keine minimale Größe besitzt,
/// die die Größe des Vordergrundes übersteigt.
///
/// Um den Vorder- und Hintergrund verwenden zu können,
/// besitzt`BackgroundNode` zwei Kinder,
/// die sich im Array `children` befinden.
/// An der ersten Position steht der Knoten, der den Vordergrund darstellt.
/// An der letzten Position befindet sich der Hintergrund.
///
/// Damit der Hintergrund auch hinter dem Vordergrund erscheint,
/// wird zuerst der Hintergrund gezeichnet und danach der Vordergrund.
final class BackgroundNode: JustifiableNode {
	
    /// Ausrichtung des Hintergrundes.
	let alignment: Alignment
	
	init(alignment: Alignment) {
		self.alignment = alignment
	}
	
	override func justifyBounds() {
		if let foreground = children.first {
            // Berechnet die Begrenzungen des Vordergrundes.
			foreground.justifyBounds()
            // Übernimmt die Begrenzungen des Vordergrundes.
			self.minWidth = foreground.minWidth
			self.minHeight = foreground.minHeight
			self.maxWidth = foreground.maxWidth
			self.maxHeight = foreground.maxHeight
		}
	}
	
	override func justify(proposedWidth: Double, proposedHeight: Double) {
		if let foreground = children.first {
			foreground.justify(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
			
            // Die Größe des Vordergrundes wird übernommen.
			self.width = foreground.width
			self.height = foreground.height
			
            // Schlägt dem Hintergrund die Größe des Vordergrundes vor.
			if let background = children.last {
				background.justify(proposedWidth: self.width, proposedHeight: self.height)
			}
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
	
	override func draw(in context: GraphicsContext) {
        // Der Hintergrund wird als erstes gezeichnet.
		if let background = children.last {
			background.draw(in: context)
		}
		
        // Der Vordergrund wird als letztes gezeichnet,
        // um über den Hintergrund zu erscheinen.
		if let foreground = children.first {
			foreground.draw(in: context)
		}
	}
}
