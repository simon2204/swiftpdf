class StackNode: AlignmentNode {
	
	let mainAxis: Axis?
	
	init(mainAxis: Axis? = nil) {
		self.mainAxis = mainAxis
	}
}

enum Axis {
	case vertical
	case horizontal
}
