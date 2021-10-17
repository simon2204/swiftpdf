public enum Edge: Int8, CaseIterable {
	case top, leading, bottom, trailing
	
	public struct Set: OptionSet {
		public let rawValue: Int8
		
		public init(rawValue: Int8) {
			self.rawValue = rawValue
		}
		
		public static let top: Edge.Set = .init(rawValue: 1 << Edge.top.rawValue)
		public static let leading: Edge.Set = .init(rawValue: 1 << Edge.leading.rawValue)
		public static let bottom: Edge.Set = .init(rawValue: 1 << Edge.bottom.rawValue)
		public static let trailing: Edge.Set = .init(rawValue: 1 << Edge.trailing.rawValue)
		
		public static let all: Edge.Set = [.top, .leading, .bottom, .trailing]
		public static let horizontal: Edge.Set = [.leading, .trailing]
		public static let vertical: Edge.Set = [.top, .bottom]
		
		public init(_ edge: Edge) {
			self.rawValue = 1 << edge.rawValue
		}
	}
}
