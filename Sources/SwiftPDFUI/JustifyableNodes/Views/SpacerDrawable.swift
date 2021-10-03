final class SpacerDrawable: JustifiableNode {
	var minLength: Double?
    
    init(minLength: Double?) {
        self.minLength = minLength
    }
	
    override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
		size.width = minLength ?? proposedWidth
    }
    
    override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
		size.height = minLength ?? proposedHeight
    }
}
