final class ForEachDrawable: JustifiableNode {
	override func nodeWillJustifySize() {
		
		if let hStack = parent as? HStackDrawable {
			hStack.replace(node: self, with: children)
		}
		
		super.nodeWillJustifySize()
	}
}
