import Foundation

struct CrossReferenceTable {
    private var entries = [Entry(offset: 0, generation: 65535, isInUse: false)]
    
    var data: Data {
        var tableData: Data = "xref"
        tableData += Whitespace.crlf
        tableData += "0 \(entries.count)"
        tableData += Whitespace.crlf
        tableData += entries.joined()
        return tableData
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

extension Array where Element == CrossReferenceTable.Entry {
    func joined() -> Data {
        reduce(into: Data(capacity: count * 20)) { partialJoinedData, entry in
            partialJoinedData += entry.data
        }
    }
}
