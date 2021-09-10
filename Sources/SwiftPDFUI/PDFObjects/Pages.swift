import Foundation

struct Pages: PDFObject {
    private static let type = NamedObject(name: "Pages")
    
    let kids: [Reference<Page>]

    var pdfData: Data {
        ["Type": Self.type,
         "Kids": kids].pdfData
    }
}
