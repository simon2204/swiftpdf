extension Sequence {
    func sum<Value: Numeric>(of keypath: KeyPath<Element, Value>) -> Value {
        self.lazy.reduce(0) { $0 + $1[keyPath: keypath] }
    }
    
    func max<Value: Comparable>(of keypath: KeyPath<Element, Value>) -> Value? {
        self.lazy.max { $0[keyPath: keypath] < $1[keyPath: keypath]}?[keyPath: keypath]
    }
}
