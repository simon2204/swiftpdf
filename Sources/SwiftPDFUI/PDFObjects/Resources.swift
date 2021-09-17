struct Resources {
    /// A dictionary that maps resource names to graphics state parameter dictionaries.
    var extGState: [Name : ExpressibleAsPDFString]?
    
    /// A dictionary that maps each resource name to either the name of a device-dependent colour space
    /// or an array describing a colour space.
    var colorSpace: [Name : ExpressibleAsPDFString]?
    
    /// A dictionary that maps resource names to pattern objects.
    var pattern: [Name : ExpressibleAsPDFString]?
    
    /// A dictionary that maps resource names to shading dictionaries.
    var shading: [Name : ExpressibleAsPDFString]?
    
    /// A dictionary that maps resource names to external objects.
    var xObject: [Name : ExpressibleAsPDFString]?
    
    /// A dictionary that maps resource names to font dictionaries.
    var font: [Name : ExpressibleAsPDFString]?
    
    /// A dictionary that maps resource names to property list dictionaries for marked-content.
    var properties: [Name : ExpressibleAsPDFString]?
}

extension Resources: ExpressibleAsPDFDictionary {
    var pdfDictionary: [Name : ExpressibleAsPDFString] {
        
        var dict = [Name : ExpressibleAsPDFString]()
        
        if let extGState = extGState {
            dict["extGState"] = extGState
        }
        
        if let colorSpace = colorSpace {
            dict["colorSpace"] = colorSpace
        }
        
        if let pattern = pattern {
            dict["pattern"] = pattern
        }
        
        if let shading = shading {
            dict["shading"] = shading
        }
        
        if let xObject = xObject {
            dict["xObject"] = xObject
        }
        
        if let font = font {
            dict["font"] = font
        }
        
        if let properties = properties {
            dict["properties"] = properties
        }
        
        return dict
    }
}
