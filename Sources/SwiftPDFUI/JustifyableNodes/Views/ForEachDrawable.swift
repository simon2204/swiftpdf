final class ForEachDrawable: JustifiableNode {
	override func nodeWillJustifySelf() {
		
		if let hStack = parent as? HStackDrawable, let children = children {
			hStack.replace(node: self, with: children)
		}
		
		super.nodeWillJustifySelf()
	}
}
