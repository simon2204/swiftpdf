import Foundation

struct Page: PDFObject {
    private static let type = NamedObject(name: "Page")
    
    let parent: Reference<Catalog>
    
    let resources: [NamedObject: PDFObject]
    
    let mediaBox: Rectangle
    
    let contents: [Reference<Stream>]
    
    var pdfData: Data {
        ["Type": Self.type,
         "Parent": parent,
         "MediaBox": mediaBox,
         "Resources": resources,
         "Contents": contents].pdfData
    }
}
