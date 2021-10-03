final class RootDrawable: JustifiableNode {
	func layoutSubViews() {
		nodeWillJustifySize()
		justifyWidth(proposedWidth: size.width, proposedHeight: size.height)
		justifyHeight(proposedWidth: size.width, proposedHeight: size.height)
		nodeDidJustifySize()
		nodeWillJustifyAchsis()
		justify(x: origin.x)
		justify(y: origin.y)
		nodeDidJustifyAchsis()
	}
}
