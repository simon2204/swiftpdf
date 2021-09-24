public struct Alignment {
	public var horizontal: HorizontalAlignment
	public var vertical: VerticalAlignment
	
	public init(horizontal: HorizontalAlignment, vertical: VerticalAlignment) {
		self.horizontal = horizontal
		self.vertical = vertical
	}
	
	public static let center = Alignment(horizontal: .center, vertical: .center)
	
	public static let leading = Alignment(horizontal: .leading, vertical: .center)
	
	public static let trailing = Alignment(horizontal: .trailing, vertical: .center)
	
	public static let top = Alignment(horizontal: .center, vertical: .top)
	
	public static let bottom = Alignment(horizontal: .center, vertical: .bottom)
	
	public static let topLeading = Alignment(horizontal: .leading, vertical: .top)
	
	public static let topTrailing = Alignment(horizontal: .trailing, vertical: .top)
	
	public static let bottomLeading = Alignment(horizontal: .leading, vertical: .bottom)
	
	public static let bottomTrailing = Alignment(horizontal: .trailing, vertical: .bottom)
}

public enum HorizontalAlignment {
	case leading
	case center
	case trailing
}

public enum VerticalAlignment {
	case top
	case center
	case bottom
	case firstTextBaseline
	case lastTextBaseline
}
