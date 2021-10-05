final class ForEachDrawable: JustifiableNode {
	override func nodeWillJustifyBounds() {
		parent?.replace(self, with: children)
		super.nodeWillJustifyBounds()
	}
}
