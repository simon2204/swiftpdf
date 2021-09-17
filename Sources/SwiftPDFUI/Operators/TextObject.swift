enum TextObject {
	/// Begin a text object.
	case begin
	/// End a text object.
	case end
}

extension TextObject: ExpressibleAsPDFString {
	var pdfString: String {
		switch self {
		case .begin:
			return "BT"
			
		case .end:
			return "ET"
		}
	}
}
