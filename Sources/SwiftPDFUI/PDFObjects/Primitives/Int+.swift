extension Int: ExpressibleAsPDFString {
    var pdfString: String {
        "\(self)"
    }
}

extension Int {
    /// Formats an `Int` to the the given length.
    ///
    /// For example a value of 35 and a given integer length of 5
    /// will fill the value of 35 with three additional leading zeros
    /// and returns it as a `String`, in this case "00035".
    ///
    /// - Parameter integerLength: Length of the `Int`-value after formatting.
    /// - Returns: `String`-value of the formatted value.
    func formatted(integerLength: Int) -> String {
        self.formatted(.number.precision(.integerLength(integerLength)).grouping(.never))
    }
}
