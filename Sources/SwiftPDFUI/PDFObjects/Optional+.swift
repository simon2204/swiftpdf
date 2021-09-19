import Foundation

extension Optional: ExpressibleAsPDFData where Wrapped: ExpressibleAsPDFData {
	var pdfData: Data {
		switch self {
		case .none:
            return Null().pdfData
		case .some(let wrapped):
			return wrapped.pdfData
		}
	}
}

extension Optional: ExpressibleAsPDFString where Wrapped: ExpressibleAsPDFString {
	var pdfString: String {
		switch self {
		case .none:
            return Null().pdfString
		case .some(let wrapped):
			return wrapped.pdfString
		}
	}
}
