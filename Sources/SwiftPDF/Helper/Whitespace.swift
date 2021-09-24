enum Whitespace: String {
    case horizontalTab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
    case crlf = "\r\n"
    case space = " "
}

extension Whitespace: ExpressibleAsPDFString {
	var pdfString: String {
		self.rawValue
	}
}
