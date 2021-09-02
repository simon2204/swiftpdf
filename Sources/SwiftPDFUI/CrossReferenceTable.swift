import Foundation

struct CrossReferenceTable {
    var entries: Data
    
    
    mutating func append(entry: Entry) {
        
    }
    
    
    
}

extension CrossReferenceTable {
    struct Entry {
        /// 10-digit byte offset in the decoded stream.
        var offset: Int
        /// 5-digit generation number.
        var generation: Int
        /// Identifying this as an in-use entry.
        var inUse: Bool = true
    }
}

fileprivate extension Data {
    init(entry: CrossReferenceTable.Entry) {
        self.init()
    }
}
