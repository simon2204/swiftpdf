import Foundation

struct Resources {
    /// A dictionary that maps resource names to graphics state parameter dictionaries.
    var extGState: [NamedObject : PDFObject]?
    
    /// A dictionary that maps each resource name to either the name of a device-dependent colour space
    /// or an array describing a colour space.
    var colorSpace: [NamedObject : PDFObject]?
    
    /// A dictionary that maps resource names to pattern objects.
    var pattern: [NamedObject : PDFObject]?
    
    /// A dictionary that maps resource names to shading dictionaries.
    var shading: [NamedObject : PDFObject]?
    
    /// A dictionary that maps resource names to external objects.
    var xObject: [NamedObject : PDFObject]?
    
    /// A dictionary that maps resource names to font dictionaries.
    var font: [NamedObject : PDFObject]?
    
    /// A dictionary that maps resource names to property list dictionaries for marked-content.
    var properties: [NamedObject : PDFObject]?
}

extension Resources: PDFDictionary {
    var dictionary: [NamedObject : PDFObject] {
        
        var dict = [NamedObject : PDFObject]()
        
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
