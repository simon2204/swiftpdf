/// The pages of a document are accessed through a structure known as the page tree,
/// which defines the ordering of pages in the document.
/// Using the tree structure, PDF readers using only limited memory,
/// can quickly open a document containing thousands of pages.
/// The tree contains nodes of two types — intermediate nodes, called page tree nodes,
/// and leaf nodes, called page objects
struct Pages {
    /// The type of PDF object that this dictionary describes.
    private let type: Name = "pages"
    
    /// An array of indirect references to the immediate children of this node.
    /// The children shall only be page objects or other page tree nodes.
    let kids: [Reference<Page>]
    
    /// The number of leaf nodes (page objects) that are descendants of this node within the page tree.
    private var count: Int {
        kids.count
    }
}

extension Pages: PDFDictionary {
    var dictionary: [Name : ExpressibleAsPDFObject] {
        ["type" : type,
         "kids" : kids,
         "count" : count]
    }
}
