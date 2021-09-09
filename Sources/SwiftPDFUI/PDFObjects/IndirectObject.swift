import Foundation

struct IndirectObject: PDFObject {
    
    /// Count of created `IndirectObject`s starting from zero.
    private static var objectCount = 0
    
    /// Unique object identifier by which other objects can refer to.
    private let id: Identifier
    
    /// The object which gets to be labelled as an `IndirectObject`.
    private let object: PDFObject
    
    /// The object may be referred to from elsewhere in the file by an indirect reference.
    var reference: Reference {
        Reference(id: id)
    }
    
    init(object: PDFObject) {
        id = Identifier(objectNumber: Self.objectCount, generationNumber: 0)
        self.object = object
        Self.objectCount += 1
    }
    
    var pdfData: Data {
        "\(id.objectNumber) \(id.generationNumber) obj"
        + Whitespace.crlf
        + object.pdfData
        + Whitespace.crlf
        + "endobj"
    }
    
    
    struct Reference: PDFObject {
        fileprivate let id: Identifier
        
        var pdfData: Data {
            "\(id.objectNumber) \(id.generationNumber) R"
        }
    }
    
    fileprivate struct Identifier {
        /// A positive integer object number.
        let objectNumber: Int
        
        /// A non-negative integer generation number.
        let generationNumber: Int
    }
}
