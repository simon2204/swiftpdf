struct Catalog: PDFDictionary {
    private let type: Name = "catalog"
    
    var pages: Reference<Pages>
    
    var dictionary: [Name : PDFObject] {
        ["type" : type, "pages" : pages]
    }
}
