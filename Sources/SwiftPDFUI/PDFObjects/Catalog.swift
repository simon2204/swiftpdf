import Foundation

struct Catalog: PDFObject {
    private static let type = NamedObject(name: "Catalog")
    
    let pages: Reference<Pages>
    
    var pdfData: Data {
        ["Type": Self.type,
         "Pages": pages].pdfData
    }
}
