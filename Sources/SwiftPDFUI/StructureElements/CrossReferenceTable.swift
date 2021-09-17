/// Contains information that permits random access to indirect objects.
///
/// The cross-reference table contains information that permits random access to indirect objects
/// within the PDF file so that the entire PDF file need not be read to locate any particular object.
struct CrossReferenceTable: ExpressibleAsPDFString {
    private var entries = [Entry(offset: 0, generation: 65535, isInUse: false)]
    
    /// Concatenates all entrie's data property and returns a single `String` object.
    private var entryValues: String {
        entries.lazy.map { $0.pdfString }.joined(separator: Whitespace.crlf.rawValue)
    }
    
    mutating func append(entry: Entry) {
        entries.append(entry)
    }
    
    var pdfString: String {
        "xref"
        + Whitespace.crlf
        + "0 \(entries.count)"
        + Whitespace.crlf
        + entryValues
        + Whitespace.crlf
    }
}

extension CrossReferenceTable {
    struct Entry {
        /// 10-digit byte offset in the decoded stream.
        var offset: Int
        /// 5-digit generation number.
        var generation = 0
        /// Identifying this as an in-use entry.
        var isInUse = true
    }
}

extension CrossReferenceTable.Entry: ExpressibleAsPDFString {
    var pdfString: String {
        let offset = offset.formatted(integerLength: 10)
        let generation = generation.formatted(integerLength: 5)
        let isInUse = isInUse ? "n" : "f"
        return "\(offset) \(generation) \(isInUse)"
    }
}
