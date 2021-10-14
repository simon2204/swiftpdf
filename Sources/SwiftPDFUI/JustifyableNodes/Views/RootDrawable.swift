final class RootDrawable: JustifiableNode {
	
	let pageSize: Size
	
	init(pageSize: Size) {
		self.pageSize = pageSize
	}
	
	func layoutSubViews() {
		nodeWillJustifySize()
		justify(
			proposedWidth: pageSize.width,
			proposedHeight: pageSize.height
		)
		nodeDidJustifySize()
		nodeWillJustifyAchsis()
		justify(x: (pageSize.width - self.width) / 2)
		justify(y: (pageSize.height - self.height) / 2)
		nodeDidJustifyAchsis()
	}
}
