final class RootDrawable: JustifiableNode {
	func layoutSubViews() {
		nodeWillJustifySelf()
		justifyWidth(proposedWidth: size.width, proposedHeight: size.height)
		justifyHeight(proposedWidth: size.width, proposedHeight: size.height)
		justify(x: origin.x)
		justify(y: origin.y)
		nodeDidJustifySelf()
	}
}
