public struct EdgeInsets: Equatable {
	public var top: Double
	public var leading: Double
	public var bottom: Double
	public var trailing: Double
	
	public init(top: Double, leading: Double, bottom: Double, trailing: Double) {
		self.top = top
		self.leading = leading
		self.bottom = bottom
		self.trailing = trailing
	}
	
	public init() {
		self.init(top: 0, leading: 0, bottom: 0, trailing: 0)
	}
}

extension EdgeInsets {
	init(all: Double) {
		self.init(top: all, leading: all, bottom: all, trailing: all)
	}
}
