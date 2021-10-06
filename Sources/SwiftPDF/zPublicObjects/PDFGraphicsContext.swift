import Foundation

public class PDFGraphicsContext {
	private var operations: [ExpressibleAsPDFString] = []
	
	// MARK: - Constructing a Current Graphics Path
	
	/// Begins a new subpath at the specified point.
	///
	/// The specified point becomes the start point of a new subpath.
	/// The current point is set to this start point.
	///
	/// - Parameter point: The point, in user space coordinates, at which to start a new subpath.
	///
	public func move(to point: PDFPoint) {
		operations.append(PathConstruction.move(x: point.x, y: point.y))
	}
	
	/// Appends a straight line segment from the current point to the specified point.
	///
	/// After adding the line segment, the current point is set to the endpoint of the line segment.
	///
	/// - Parameter point: The location, in user space coordinates, for the end of the new line segment.
	///
	public func addLine(to point: PDFPoint) {
		operations.append(PathConstruction.line(x: point.x, y: point.y))
	}
	
	/// Adds a sequence of connected straight-line segments to the current path.
	///
	/// Calling this convenience method is equivalent to calling the ``move(to:)``
	/// method with the first value in the points array,
	/// then calling the ``addLine(to:)``
	/// method for each subsequent point until the array is exhausted.
	/// After calling this method, the path's current point is the last point in the array.
	///
	/// - Parameter points:
	/// An array of values that specify the start and end points of the line segments to draw.
	/// Each point in the array specifies a position in user space.
	/// The first point in the array specifies the initial starting point.
	///
	public func addLines(between points: [PDFPoint]) {
		var iterator = points.makeIterator()
		
		if let firstPoint = iterator.next() {
			move(to: firstPoint)
			
			while let nextPoint = iterator.next() {
				addLine(to: nextPoint)
			}
		}
	}
	
	/// Adds a rectangular path to the current path.
	///
	/// This is a convenience function that adds a rectangle to a path,
	/// starting by moving to the bottom left corner
	/// and then adding lines counter-clockwise to create a rectangle,
	/// closing the subpath.
	///
	/// - Parameter rect: A rectangle, specified in user space coordinates.
	///
	public func addRect(_ rect: PDFRect) {
		operations.append(
			PathConstruction.rectangle(
				x: rect.origin.x,
				y: rect.origin.y,
				width: rect.width,
				height: rect.height
			)
		)
	}
	
	/// Adds a set of rectangular paths to the current path.
	///
	/// Calling this convenience method is equivalent to repeatedly calling the
	/// ``addRect(_:)`` method for each rectangle in the array.
	///
	/// - Parameter rects: An array of rectangles, specified in user space coordinates.
	///
	public func addRects(_ rects: [PDFRect]) {
		rects.forEach(addRect)
	}
	
	/// Adds a cubic Bézier curve to the current path, with the specified end point and control points.
	///
	/// This method constructs a curve starting from the path's current point
	/// and ending at the specified end point,
	/// with curvature defined by the two control points.
	/// After this method appends that curve to the current path,
	/// the end point of the curve becomes the path's current point.
	///
	/// - Parameters:
	///   - end: The point, in user space coordinates, at which to end the curve.
	///   - control1: The first control point of the curve, in user space coordinates.
	///   - control2: The second control point of the curve, in user space coordinates.
	///
	public func addCurve(to end: PDFPoint, control1: PDFPoint, control2: PDFPoint) {
		operations.append(
			PathConstruction.cubic1(
				x1: control1.x,
				y1: control1.y,
				x2: control2.x,
				y2: control2.y,
				x3: end.x,
				y3: end.y
			)
		)
	}
	
	/// Adds a quadratic Bézier curve to the current path, with the specified end point and control point.
	///
	/// This method constructs a curve starting from the path’s current point
	/// and ending at the specified end point, with curvature defined by the control point.
	/// After this method appends that curve to the current path,
	/// the end point of the curve becomes the path’s current point.
	///
	/// - Parameters:
	///   - end: The point, in user space coordinates, at which to end the curve.
	///   - control: The control point of the curve, in user space coordinates.
	///
	public func addQuadCurve(to end: PDFPoint, control: PDFPoint) {
		addCurve(to: end, control1: control, control2: control)
	}
	
	/// Adds an ellipse that fits inside the specified rectangle.
	///
	/// The ellipse is approximated by a sequence of Bézier curves.
	/// Its center is the midpoint of the rectangle defined by the rect parameter.
	/// If the rectangle is square, then the ellipse is circular with a radius equal
	/// to one-half the width (or height) of the rectangle.
	/// If the rect parameter specifies a rectangular shape,
	/// then the major and minor axes of the ellipse are defined
	/// by the width and height of the rectangle.
	///
	/// - Parameter rect: A rectangle that defines the area for the ellipse to fit in.
	///
	public func addEllipse(in rect: PDFRect) {
		let kappa = 4 * (sqrt(2) - 1) / 3
		
		let horizontalControlPointOffset = rect.width / 2 * kappa
		let verticalControlPointOffset = rect.height / 2 * kappa
		
		let maxX = rect.maxX
		let maxY = rect.maxY
		let midX = rect.midX
		let midY = rect.midY
		let minX = rect.minX
		let minY = rect.minY
		
		move(to: PDFPoint(x: minX, y: midY))
		
		addCurve(
			to: PDFPoint(x: midX, y: minY),
			control1: PDFPoint(x: minX, y: midY - verticalControlPointOffset),
			control2: PDFPoint(x: midX - horizontalControlPointOffset, y: minY)
		)
		addCurve(
			to: PDFPoint(x: maxX, y: midY),
			control1: PDFPoint(x: midX + horizontalControlPointOffset, y: minY),
			control2: PDFPoint(x: maxX, y: midY - verticalControlPointOffset)
		)
		
		addCurve(
			to: PDFPoint(x: midX, y: maxY),
			control1: PDFPoint(x: maxX, y: midY + verticalControlPointOffset),
			control2: PDFPoint(x: midX + horizontalControlPointOffset, y: maxY)
		)
		
		addCurve(
			to: PDFPoint(x: minX, y: midY),
			control1: PDFPoint(x: midX - horizontalControlPointOffset, y: maxY),
			control2: PDFPoint(x: minX, y: midY + verticalControlPointOffset)
		)
	}
	
	/// Closes and terminates the current path’s subpath.
	///
	/// Appends a line from the current point to the starting point
	/// of the current subpath and ends the subpath.
	///
	public func closePath() {
		operations.append(PathConstruction.close)
	}
	
	// MARK: - Drawing the Current Graphics Path
	
	public func drawPath(using mode: PDFPathDrawingMode) {
		let paintingOperation: PathPainting
		
		switch mode {
		case .fill:
			paintingOperation = .fill
			
		case .evenOddFill:
			paintingOperation = .fillEvenOdd
			
		case .stroke:
			paintingOperation = .stroke
			
		case .fillStroke:
			paintingOperation = .fillAndStroke
			
		case .evenOddFillStroke:
			paintingOperation = .fillAndStrokeEvenOdd
		}
		
		operations.append(paintingOperation)
	}
	
	/// Options for rendering a path.
	public enum PDFPathDrawingMode {
		/// Render the area contained within the path using the non-zero winding number rule.
		case fill
		/// Render the area within the path using the even-odd rule.
		case evenOddFill
		/// Render a line along the path.
		case stroke
		/// First fill and then stroke the path, using the nonzero winding number rule.
		case fillStroke
		/// First fill and then stroke the path, using the even-odd rule.
		case evenOddFillStroke
	}

	/// Paints the area within the current path, as determined by the specified fill rule.
	///
	/// - Parameter rule:
	/// The rule for determining which areas to treat as the interior of the path.
	/// See ``PDFPathFillRule``.
	/// This parameter defaults to the ``PDFPathFillRule/winding`` rule if unspecified.
	public func fillPath(using rule: PDFPathFillRule = .winding) {
		switch rule {
		case .evenOdd:
			drawPath(using: .evenOddFill)
		case .winding:
			drawPath(using: .fill)
		}
	}
	
	/// Paints a line along the current path.
	///
	/// The line width and stroke color of the context’s graphics state are used to paint the path.
	public func strokePath() {
		drawPath(using: .stroke)
	}
		
	/// Rules for determining which regions are interior to a path,
	/// used by the fillPath(using:) and clip(using:) methods.
	public enum PDFPathFillRule {
		/// A rule that considers a region to be interior to a path
		/// based on the number of times it is enclosed by path elements.
		case evenOdd
		/// A rule that considers a region to be interior to a path
		/// if the winding number for that region is nonzero.
		case winding
	}
	
	// MARK: - Drawing Text
	
	/// All fonts used in the GraphicsContext.
	var appliedFonts = Set<PDFFont>()
	
	/// Currently used font.
	private var currentFont: PDFFont = .helvetica
	
	/// Currently used font size in text space units.
	private var currentFontSize: Double = 0
	
	/// Sets the font in a graphics context.
	///
	/// - Parameter font: A font.
	public func setFont(_ font: PDFFont) {
		currentFont = font
	}
	
	/// Sets the current font size.
	///
	/// - Parameter size: A font size, expressed in text space units.
	///
	public func setFontSize(_ size: Double) {
		currentFontSize = size
	}
	
	/// Displays a character string at a position you specify.
	///
	/// - Parameters:
	///   - text: A text to draw.
	///   - position: A point (in user space) at which to display the text.
	///
	public func showText<S: StringProtocol>(_ text: S, at position: PDFPoint) {
		showTextLines([text], at: position)
	}
	
	public func showTextLines<S: StringProtocol>(_ lines: [S], at position: PDFPoint, leading: Double = 20) {
		guard !lines.isEmpty else { return }
		
		// Begin text
		operations.append(TextObject.begin)
		
		operations.append(TextState.leading(leading))
		
		// Positioning text
		operations.append(TextPositioning.move(dx: position.x, dy: position.y))
		
		// Set font and size
		operations.append(TextState.font(
			fontResource: currentFont.resourceName,
			scaleFactor: currentFontSize)
		)
		
		//operations.append(PDFColor.black.fill())
		
		// Append text
		
		var iterator = lines.makeIterator()
		
		if let first = iterator.next() {
			operations.append(TextShowing.show(HexadecimalString(first)))
			
			while let next = iterator.next() {
				operations.append(TextShowing.nextLine(HexadecimalString(next)))
			}
		}
		
		// End text
		operations.append(TextObject.end)
		
		appliedFonts.insert(currentFont)
	}
	
	// MARK: - Setting Fill and Stroke Colors
	
	public func setFillColor(_ color: PDFColor) {
		operations.append(color.fill())
	}
	
	public func setStrokeColor(_ color: PDFColor) {
		operations.append(color.stroke())
	}
	
	// MARK: - Setting Path Drawing Options
	
	/// Sets the line width for a graphics context.
	///
	/// The default line width is 1 unit.
	/// When stroked, the line straddles the path,
	/// with half of the total width on either side.
	///
	/// - Parameter width:
	/// The new line width to use, in user space units.
	/// The value must be greater than 0.
	///
	public func setLineWidth(_ width: Double) {
		operations.append(GraphicsState.lineWidth(width))
	}
	
	/// Sets the pattern for drawing dashed lines.
	///
	/// - Parameters:
	///   - phase:
	///   A value that specifies how far into the dash pattern the line starts, in units of the user space.
	///   For example, a value of 0 draws a line starting with the beginning of a dash pattern,
	///   and a value of 3 means the line is drawn with the dash pattern starting at three units from its beginning.
	///
	///   - lengths:
	///   An array of values that specify the lengths, in user space coordinates,
	///   of the painted and unpainted segments of the dash pattern.
	///   For example, the array [2,3] sets a dash pattern that alternates between a 2-unit-long painted segment
	///   and a 3-unit-long unpainted segment.
	///   The array [1,3,4,2] sets the pattern to a 1-unit painted segment,
	///   a 3-unit unpainted segment, a 4-unit painted segment,
	///   and a 2-unit unpainted segment.
	///   Pass an empty array to clear the dash pattern so that all stroke drawing in the context uses solid lines.
	///
	public func setLineDash(phase: Double, lengths: [Double]) {
		operations.append(GraphicsState.lineDashPattern(dash: lengths, phase: phase))
	}
	
	/// Sets the accuracy of curved paths in a graphics context.
	///
	/// This function controls how accurately curved paths are rendered.
	/// Setting the flatness value to less than 1.0 renders highly accurate curves,
	/// but lengthens rendering times.
	///
	/// In most cases, you should not change the flatness value.
	/// Customizing the flatness value for the capabilities of a particular output device
	/// impairs the ability of your application to render to other devices.
	///
	/// - Parameter flatness: The largest permissible distance, measured in device pixels,
	/// between a point on the true curve and a point on the approximated curve.
	///
	public func setFlatness(_ flatness: Double) {
		operations.append(GraphicsState.flatness(flatness))
	}
	
	/// Sets the miter limit for the joins of connected lines in a graphics context.
	///
	/// If the current line join style is set to CGLineJoin.miter,
	/// the miter limit determines whether the lines should be joined with a bevel instead of a miter.
	/// The length of the miter is divided by the line width.
	/// If the result is greater than the miter limit, the style is converted to a bevel.
	///
	/// - Parameter limit: The miter limit to use.
	///
	public func setMiterLimit(_ limit: Double) {
		operations.append(GraphicsState.miterLimit(limit))
	}
	
	/// Sets the style for the joins of connected lines in a graphics context.
	///
	/// - Parameter join:
	/// A line join value—``PDFLineJoin/miter`` (the default),
	/// ``PDFLineJoin/round``, or ``PDFLineJoin/bevel``.
	///
	public func setLineJoin(_ join: PDFLineJoin) {
		let lineJoinStyle: GraphicsState.LineJoinStyle
		
		switch join {
		case .miter:
			lineJoinStyle = .miter
		case .round:
			lineJoinStyle = .round
		case .bevel:
			lineJoinStyle = .bevel
		}
		
		operations.append(GraphicsState.lineJoin(lineJoinStyle))
	}
	
	public enum PDFLineJoin {
		/// Miter join.
		///
		/// The outer edges of the strokes for the two segments
		/// shall be extended until they meet at an angle, as in a picture frame.
		/// If the segments meet at too sharp an angle, a bevel join shall be used instead.
		case miter
		
		/// Round join.
		///
		/// An arc of a circle with a diameter equal to the line width shall be drawn
		/// around the point where the two segments meet,
		/// connecting the outer edges of the strokes for the two segments.
		/// This pie-slice-shaped figure shall be filled in, producing a rounded corner.
		case round
		
		/// Bevel join.
		///
		/// The two segments shall be finished with butt caps
		/// and the resulting notch beyond the ends of the segments shall be filled with a triangle.
		case bevel
	}
	
	/// Sets the style for the endpoints of lines drawn in a graphics context.
	///
	/// - Parameter cap:
	/// A line cap style constant—``PDFLineCap/butt`` (the default),
	/// ``PDFLineCap/round``, or ``PDFLineCap/projectingSquare``.
	///
	public func setLineCap(_ cap: PDFLineCap) {
		let capStyle: GraphicsState.LineCapStyle
		
		switch cap {
		case .butt:
			capStyle = .butt
			
		case .round:
			capStyle = .round
			
		case .projectingSquare:
			capStyle = .projectingSquare
		}
		
		operations.append(GraphicsState.lineCap(capStyle))
	}
	
	/// Styles for rendering the endpoint of a stroked line.
	///
	/// A line cap specifies the method used by ``strokePath()``
	/// to draw the endpoint of the line.
	/// To change the line cap style in a graphics context,
	/// you use the function ``setLineCap(_:)``.
	public enum PDFLineCap {
		/// A line with a squared-off end.
		case butt
		
		/// A line with a rounded end.
		case round
		
		/// A line with a squared-off end.
		case projectingSquare
	}

	// MARK: - Saving and Restoring Graphics State
	
	/// Pushes a copy of the current graphics state onto the graphics state stack for the context.
	public func saveGState() {
		operations.append(GraphicsState.save)
	}
	
	/// Sets the current graphics state to the state most recently saved.
	public func restoreGState() {
		operations.append(GraphicsState.restore)
	}
}

extension PDFGraphicsContext: ExpressibleAsPDFStream {
	var pdfStream: [ExpressibleAsPDFData] {
		operations
	}
}
