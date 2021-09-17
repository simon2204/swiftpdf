struct Catalog: ExpressibleAsPDFDictionary {
    private let type: Name = "catalog"
    
    var pages: IndirectReference<Pages>
    
    var dictionary: [Name : ExpressibleAsPDFString] {
        ["type" : type, "pages" : pages]
    }
}
