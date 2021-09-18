enum PathClipping: String {
    /// Modify the current clipping path by intersecting it with the current path,
    /// using the non-zero winding number rule to determine which regions lie inside the clipping path.
    case nonZeroWindingNumber = "W"
    
    /// Modify the current clipping path by intersecting it with the current path,
    /// using the even-odd rule to determine which regions lie inside the clipping path.
    case evenOdd = "W*"
}

extension PathClipping: ExpressibleAsPDFString {
    var pdfString: String {
        self.rawValue
    }
}
