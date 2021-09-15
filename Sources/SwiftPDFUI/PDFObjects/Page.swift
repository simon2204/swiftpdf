/// The leaves of the page tree are page objects,
/// each of which is a dictionary specifying the attributes of a single page of the document.
struct Page {
    /// The type of PDF object that this dictionary describes.
    private let type: Name = "page"
    
    /// The page tree node that is the immediate parent of this page object.
    var parent: Reference<Catalog>
    
    /// A dictionary containing any resources required by the page contents.
    var resources: Resources = Resources()
    
    /// A rectangle expressed in default user space units,
    /// that shall define the boundaries of the physical medium on which the page shall be displayed or printed.
    var mediaBox: Rectangle
    
    /// A rectangle, expressed in default user space units,
    /// that shall define the visible region of default user space.
    /// When the page is displayed or printed, its contents shall be clipped.
    /// Default value: the value of MediaBox.
    var cropBox: Rectangle?
    
    /// A content stream that shall describe the contents of this page.
    /// If this entry is absent, the page shall be empty.
    var contents: [Reference<Stream>]?
    
    /// The number of degrees by which the page shall be rotated clockwise when displayed or printed.
    var rotate: Int?
}

extension Page: PDFDictionary {
    var dictionary: [Name : PDFObject] {
        
        var dict: [Name : PDFObject]
        
        dict = ["type" : type,
                "parent" : parent,
                "resources" : resources,
                "mediaBox" : mediaBox]
        
        if let cropBox = cropBox {
            dict["cropBox"] = cropBox
        }
        
        if let contents = contents {
            dict["contents"] = contents
        }
        
        if let rotate = rotate {
            dict["rotate"] = rotate
        }
        
        return dict
    }
}
