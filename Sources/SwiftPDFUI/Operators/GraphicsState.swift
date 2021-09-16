enum GraphicsState {
    /// Save the current graphics state on the graphics state stack.
    case save
    
    /// Restore the graphics state by removing the most recently saved state from
    /// the stack and making it the current state.
    case restore
    
    /// Modify the current transformation matrix (CTM) by concatenating the specified matrix.
    case transform(a: Double, b: Double, c: Double, d: Double, e: Double, f: Double)
    
    /// Set the line width in the graphics state.
    ///
    /// The line width parameter specifies the thickness of the line used to stroke a path.
    case lineWidth(Double)
    
    /// Set the line cap style in the graphics state.
    case lineCap(LineCapStyle)
    
    /// Set the line join style in the graphics state.
    case lineJoin(LineJoinStyle)
    
    /// Set the miter limit in the graphics state.
    ///
    /// When two line segments meet at a sharp angle
    /// and mitered joins have been specified as the line join style,
    /// it is possible for the miter to extend far beyond the thickness of the line stroking the path.
    /// The miter limit shall impose a maximum on the ratio of the miter length to the line width.
    /// When the limit is exceeded, the join is converted from a miter to a bevel.
    case miterLimit(Double)
    
    /// Set the line dash pattern in the graphics state.
    ///
    /// The line dash pattern shall control the pattern of dashes and gaps used to stroke paths.
    /// It shall be specified by a dash array and a dash phase.
    ///
    /// - Parameters:
    ///   - dash: Numbers that specify the lengths of alternating dashes and gaps.
    ///   - phase: A number that specifies the distance into the dash pattern at which to start the dash.
    case lineDashPattern(dash: [Double], phase: Double)
    
    /// Set the colour rendering intent in the graphics state.
    case intent(RenderingIntent)
    
    /// Set the flatness tolerance in the graphics state.
    ///
    /// `flatness` is a number in the range 0 to 100;
    /// a value of 0 shall specify the output device’s default flatness tolerance.
    case flatness(Double)
    
    /// Set the specified parameters in the graphics state.
    ///
    /// `dictName` shall be the name of a graphics state parameter dictionary
    /// in the ExtGState subdictionary of the current resource dictionary.
    case dictName(Name)
}

extension GraphicsState {
    /// The line cap style shall specify the shape that shall be used at both ends of open subpaths
    /// (and dashes) when they are stroked.
    enum LineCapStyle: Int {
        /// Butt cap.
        ///
        /// The stroke shall be squared off at the endpoint of the path.
        /// There shall be no projection beyond the end of the path.
        case butt
        
        /// Round cap.
        ///
        /// A semicircular arc with a diameter equal to the line width
        /// shall be drawn around the endpoint and shall be filled in.
        case round
        
        /// Projecting square cap.
        ///
        /// The stroke shall continue beyond the endpoint of the path
        /// for a distance equal to half the line width and shall be squared off.
        case projectingSquare
    }
}

extension GraphicsState {
    /// The line join style shall specify the shape to be used at the corners of paths that are stroked.
    enum LineJoinStyle: Int {
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
}

extension GraphicsState {
    /// Lists the standard rendering intents that shall be recognised.
    enum RenderingIntent: Name {
        /// AbsoluteColorimetric
        ///
        /// Colours shall be represented solely with respect to the light source;
        /// no correction shall be made for the output medium’s white point (such as the colour of unprinted paper).
        /// Thus, for example, a monitor’s white point, which is bluish compared to that of a printer’s paper,
        /// would be reproduced with a blue cast. In-gamut colours shall be reproduced exactly;
        /// out-of-gamut colours shall be mapped to the nearest value within the reproducible gamut
        ///
        /// - Note: This style of reproduction has the advantage of providing exact colour matches
        /// from one output medium to another.
        /// It has the disadvantage of causing colours with Y values between the medium’s white point and 1.0
        /// to be out of gamut.
        ///  Logos and solid colours are typical cases requiring exact reproduction across different media.
        case absoluteColorimetric
        
        /// RelativeColorimetric
        ///
        /// Colours shall be represented with respect to the combination of the light source
        /// and the output medium’s white point (such as the colour of unprinted paper).
        /// Thus, a monitor’s white point can be reproduced on a printer by simply leaving the paper unmarked,
        /// ignoring colour differences between the two media. In-gamut colours shall be reproduced exactly;
        /// out-of-gamut colours shall be mapped to the nearest value within the reproducible gamut.
        ///
        /// - Note: This style of reproduction has the advantage of adapting for the varying white points of different output media.
        /// It has the disadvantage of not providing exact colour matches from one medium to another.
        /// Vector graphics are a typical use case.
        case relativeColorimetric
        
        /// Saturation
        ///
        /// Colours shall be represented in a manner that preserves or emphasizes saturation.
        /// Reproduction of in-gamut colours may or may not be colorimetrically accurate.
        ///
        /// - Note: Business graphics are a typical use case where saturation is the most important attribute of the colour.
        case saturation
        
        /// Perceptual
        ///
        /// Colours shall be represented in a manner that provides a pleasing perceptual appearance.
        /// To preserve colour relationships,
        /// both in-gamut and out-of-gamut colours shall be generally modified from their precise colorimetric values.
        ///
        /// - Note: Scanned images are a typical use case.
        case perceptual
    }
}

extension GraphicsState: ExpressibleAsPDFString {
    var pdfString: String {
        switch self {
        case .save:
            return "q"
            
        case .restore:
            return "Q"
            
        case let .transform(a, b, c, d, e, f):
            return "\(a) \(b) \(c) \(d) \(e) \(f) cm"
            
        case let .lineWidth(lineWidth):
            return "\(lineWidth) w"
            
        case let .lineCap(lineCapStyle):
            return "\(lineCapStyle.rawValue) J"
            
        case let .lineJoin(lineJoinStyle):
            return "\(lineJoinStyle.rawValue) j"
            
        case let .miterLimit(miterLimit):
            return "\(miterLimit) M"
            
        case let .lineDashPattern(dash, phase):
            return "\(dash) \(phase) d"
            
        case let .intent(intent):
            return "\(intent) ri"
            
        case let .flatness(flatness):
            return "\(flatness) i"
            
        case let .dictName(dictName):
            return "\(dictName) gs"
        }
    }
}
