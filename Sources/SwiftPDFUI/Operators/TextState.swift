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
    ///   - fontResource: The name of a font resource in the Font subdictionary
	///   of the current resource dictionary.
    ///   - scaleFactor: A number representing a scale factor.
    case font(fontResource: Name, scaleFactor: Double)
    
    /// Set the text rendering mode.
    ///
    /// Initial value: fill.
    case render(RenderingMode)
    
    /// Set the text rise.
    ///
    /// Specifies the distance, in unscaled text space units,
	/// to move the baseline up or down from its default location.
	/// Positive values of text rise shall move the baseline up.
	///
	/// Initial value: 0.
    case rise(Double)
}

/// The text rendering mode.
///
/// The text rendering mode determines whether showing text shall cause glyph outlines
/// to be stroked, filled, used as a clipping boundary, or some combination of the three.
/// Stroking, filling, and clipping have the same effects for a text object as they do for a path object.
enum RenderingMode: Int {
	/// Fill text.
	case fill
	/// Stroke text.
	case stroke
	/// Fill, then stroke text.
	case fillAndStroke
	/// Neither fill nor stroke text (invisible).
	case invisible
	/// Fill text and add to path for clipping.
	case fillAndClip
	/// Stroke text and add to path for clipping.
	case strokeAndClip
	/// Fill, then stroke text and add to path for clipping.
	case fillStrokeAndClip
	/// Add text to path for clipping.
	case clip
}

extension TextState: ExpressibleAsPDFString {
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
			return "\(value.rawValue) Tr"
            
        case let .rise(value):
            return "\(value) Ts"
        }
    }
}
