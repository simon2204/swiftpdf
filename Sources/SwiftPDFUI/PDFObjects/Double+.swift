import Foundation

extension Double: ExpressibleAsPDFString {
    var pdfString: String {
        self.removeTailingZeros()
    }
}

extension Double {
    func removeTailingZeros() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
		formatter.decimalSeparator = "."
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16
        return formatter.string(from: number) ?? ""
    }
}
