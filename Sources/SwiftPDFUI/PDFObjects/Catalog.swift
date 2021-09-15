import Foundation

struct Catalog: PDFDictionary {
    private let type: NamedObject = "catalog"
    
    var pages: Reference<Pages>
    
    var dictionary: [NamedObject : PDFObject] {
        ["type" : type, "pages" : pages]
    }
}
