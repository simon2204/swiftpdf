struct Resources {
    /// A dictionary that maps resource names to graphics state parameter dictionaries.
    var extGState: [Name : PDFObject]?
    
    /// A dictionary that maps each resource name to either the name of a device-dependent colour space
    /// or an array describing a colour space.
    var colorSpace: [Name : PDFObject]?
    
    /// A dictionary that maps resource names to pattern objects.
    var pattern: [Name : PDFObject]?
    
    /// A dictionary that maps resource names to shading dictionaries.
    var shading: [Name : PDFObject]?
    
    /// A dictionary that maps resource names to external objects.
    var xObject: [Name : PDFObject]?
    
    /// A dictionary that maps resource names to font dictionaries.
    var font: [Name : PDFObject]?
    
    /// A dictionary that maps resource names to property list dictionaries for marked-content.
    var properties: [Name : PDFObject]?
}

extension Resources: PDFDictionary {
    var dictionary: [Name : PDFObject] {
        
        var dict = [Name : PDFObject]()
        
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
