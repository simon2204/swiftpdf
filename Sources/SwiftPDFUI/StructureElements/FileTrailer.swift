struct FileTrailer: ExpressibleAsPDFString {
    /// The total number of entries in the PDF file’s cross-reference table,
    /// as defined by the combination of the original section and all update sections.
    /// Equivalently, this value shall be 1 greater than the highest object number defined in the PDF file.
    let size: Int
    
    /// The catalog dictionary for the PDF file (see 7.7.2, "Document catalog dictionary").
    let root: IndirectReference<Catalog>
    
    /// An array of two byte-strings constituting a PDF file identifier (See 14.4, "File identifiers") for the PDF file.
    /// Each PDF file identifier byte-string shall have a minimum length of 16 bytes.
    /// If there is an Encrypt entry, this array and the two byte-strings shall be direct objects and shall be unencrypted.
    let id: [Hexadecimal]
    
    /// Byte offset of last cross-reference section.
    let crossReferenceOffset: Int
    
    var dictionary: Dictionary<Name, ExpressibleAsPDFString> {
        ["Size": size,
         "Root": root,
         "ID" : id]
    }
    
    var pdfString: String {
        """
        trailer
        \(dictionary)
        startxref
        \(crossReferenceOffset)
        %%EOF
        """
    }
}
