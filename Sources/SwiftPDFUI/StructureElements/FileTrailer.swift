import Foundation

struct FileTrailer {
    /// The total number of entries in the PDF file’s cross-reference table,
    /// as defined by the combination of the original section and all update sections.
    /// Equivalently, this value shall be 1 greater than the highest object number defined in the PDF file.
    let size: Int
    
    /// The catalog dictionary for the PDF file (see 7.7.2, "Document catalog dictionary").
    let root: IndirectObject.Reference
    
    /// An array of two byte-strings constituting a PDF file identifier (See 14.4, "File identifiers") for the PDF file.
    /// Each PDF file identifier byte-string shall have a minimum length of 16 bytes.
    /// If there is an Encrypt entry, this array and the two byte-strings shall be direct objects and shall be unencrypted.
    let id: [PDFObject]
    
    let count: Int
    
    var dictionary: Dictionary<NamedObject, PDFObject> {
        ["Size": size,
         "Root": root,
         "ID" : id]
    }
    
    var data: Data {
        "trailer"
        + Whitespace.crlf
        + dictionary.pdfData
        + Whitespace.crlf
        + "startxref"
        + Whitespace.crlf
        + String(count)
        + Whitespace.crlf
        + "%%EOF"
    }
}
