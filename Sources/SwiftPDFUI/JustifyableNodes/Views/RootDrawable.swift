final class RootDrawable: JustifiableNode {
	let pageSize: Size
	
	init(pageSize: Size) {
		self.pageSize = pageSize
	}
	
	func layoutSubViews() {
		nodeWillJustifySize()
		justifyWidth(proposedWidth: pageSize.width, proposedHeight: pageSize.height)
		justifyHeight(proposedWidth: pageSize.width, proposedHeight: pageSize.height)
		nodeDidJustifySize()
		nodeWillJustifyAchsis()
		justify(x: (pageSize.width - size.width) / 2)
		justify(y: (pageSize.height - size.height) / 2)
		nodeDidJustifyAchsis()
	}
	
//	override func justifyWidth(proposedWidth: Double, proposedHeight: Double) {
//		children.forEach { child in
//			child.justifyWidth(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
//			self.size.width += child.size.width
//		}
//	}
//	
//	override func justifyHeight(proposedWidth: Double, proposedHeight: Double) {
//		children.forEach { child in
//			child.justifyHeight(proposedWidth: proposedWidth, proposedHeight: proposedHeight)
//			self.size.height += child.size.height
//		}
//	}
}
