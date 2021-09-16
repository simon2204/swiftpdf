struct Catalog: PDFDictionary {
    private let type: Name = "catalog"
    
    var pages: Reference<Pages>
    
    var dictionary: [Name : ExpressibleAsPDFString] {
        ["type" : type, "pages" : pages]
    }
}
