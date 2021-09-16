/// Path-painting operators.
///
/// The path-painting operators end a path object,
/// causing it to be painted on the current page in the manner that the operator specifies.
/// The principal path-painting operators are `Operator.PathPainting.stroke` (for stroking)
/// and `Operator.PathPainting.fill` (for filling).
/// Variants of these operators combine stroking and filling in a single operation
/// or apply different rules for determining the area to be filled.
///
/// - Warning: Attempting to execute a painting operator when the current path is undefined
/// (at the beginning of a new page or immediately after a painting operator has been executed)
/// will generate an error.
enum PathPainting: String {
    /// Stroke the path.
    case stroke = "S"
    
    /// Close and stroke the path.
    /// This operator will have the same effect as the sequence
    /// `Operator.PathConstruction.close`, `Operator.PathPainting.stroke`.
    case closeAndStroke = "s"
    
    /// Fill the path, using the non-zero winding number rule to determine the region to fill.
    ///
    /// - Note: Any subpaths that are open will be implicitly closed before being filled.
    case fill = "f"
    
    /// Fill the path, using the even-odd rule to determine the region to fill.
    case fillEvenOdd = "f*"
    
    /// Fill and then stroke the path, using the non-zero winding number rule to determine the region to fill.
    ///
    /// This operator will produce the same result as constructing two identical path objects,
    /// painting the first with `Operator.PathPainting.fill`
    /// and the second with `Operator.PathPainting.stroke`.
    ///
    /// - Note: The filling and stroking portions of the operation
    /// consult different values of several graphics state parameters,
    /// such as the current colour.
    case fillAndStroke = "B"
    
    /// Fill and then stroke the path, using the even-odd rule to determine the region to fill.
    ///
    /// This operator will produce the same result as `Operator.PathPainting.fillAndStroke`,
    /// except that the path is filled as if with
    /// `Operator.PathPainting.fillEvenOdd`
    /// instead of `Operator.PathPainting.fill`.
    case fillAndStrokeEvenOdd = "B*"
    
    /// Close, fill, and then stroke the path, using the non-zero winding number rule to determine the region to fill.
    ///
    /// This operator will have the same effect as the sequence
    /// `Operator.PathConstruction.close`, `Operator.PathPainting.fillAndStroke`.
    case closeFillAndStroke = "b"
    
    /// Close, fill, and then stroke the path, using the even-odd rule to determine the region to fill.
    ///
    /// This operator will have the same effect as the sequence
    /// `Operator.PathConstruction.close`, `Operator.PathPainting.fillAndStrokeEvenOdd`.
    case closeFillAndStrokeEvenOdd = "b*"
    
    /// End the path object without filling or stroking it.
    /// This operator will be a path-painting no-op,
    /// used primarily for the side effect of changing the current clipping path
    case endPath = "n"
}

extension PathPainting: ExpressibleAsPDFString {
    var pdfString: String {
        self.rawValue
    }
}
