extension Operator {
    enum TextState {
        /// Set the character spacing.
        ///
        /// Initial value: 0.
        case charSpace(Double)
        
        /// Set the word spacing.
        ///
        /// Word spacing shall be used by the Tj, TJ, and ' operators.
        /// Initial value: 0.
        case wordSpace(Double)
        
        /// Set the horizontal scaling.
        ///
        /// Shall be a number specifying the percentage of the normal width.
        /// Initial value: 100 (normal width).
        case scale(Double)
        
        /// Set the text leading.
        ///
        /// Text leading shall be used only by the T*, ', and " operators.
        /// Initial value: 0.
        case leading(Double)
        
        /// Set the text font and the text font size.
        ///
        /// There is no initial value for either font or size;
        /// they shall be specified explicitly by using `font(fontResource:scaleFactor:)`
        /// before any text is shown.
        ///
        /// - Parameters:
        ///   - fontResource: The name of a font resource in the Font subdictionary of the current resource dictionary.
        ///   - scaleFactor: A number representing a scale factor.
        case font(fontResource: Name, scaleFactor: Double)
        
        /// Set the text rendering mode.
        ///
        /// Initial value: 0.
        case render(Int)
        
        /// Set the text rise.
        ///
        /// Initial value: 0.
        case rise(Double)
    }
}

extension Operator.TextState: ExpressibleAsPDFString {
    var pdfString: String {
        switch self {
        case let .charSpace(value):
            return "\(value) Tc"
            
        case let .wordSpace(value):
            return "\(value) Tw"
            
        case let .scale(value):
            return "\(value) Tz"
            
        case let .leading(value):
            return "\(value) TL"
            
        case let .font(fontResource, scaleFactor):
            return "\(fontResource) \(scaleFactor) Tf"
            
        case let .render(value):
            return "\(value) Tr"
            
        case let .rise(value):
            return "\(value) Ts"
        }
    }
}
