import Foundation

/// Contains information that permits random access to indirect objects.
///
/// The cross-reference table contains information that permits random access to indirect objects
/// within the PDF file so that the entire PDF file need not be read to locate any particular object.
struct CrossReferenceTable {
    private var entries = [Entry(offset: 0, generation: 65535, isInUse: false)]
    
    private var entryData: Data {
        entries.lazy.map { $0.data }.joined()
    }
    
    var data: Data {
        "xref"
        + Whitespace.crlf
        + "0 \(entries.count)"
        + Whitespace.crlf
        + entryData
    }
    
    mutating func append(entry: Entry) {
        entries.append(entry)
    }
}

extension CrossReferenceTable {
    struct Entry {
        /// 10-digit byte offset in the decoded stream.
        var offset: Int
        /// 5-digit generation number.
        var generation: Int
        /// Identifying this as an in-use entry.
        var isInUse: Bool = true
    }
}

extension CrossReferenceTable.Entry {
    var data: Data {
        var entryData = Data(capacity: 20)
        
        let offset = offset.formatted(integerLength: 10)
        let generation = generation.formatted(integerLength: 5)
        let isInUse = isInUse ? "n" : "f"
        
        entryData += offset
        entryData += Whitespace.space
        entryData += generation
        entryData += Whitespace.space
        entryData += isInUse
        entryData += Whitespace.crlf
        
        return entryData
    }
}
