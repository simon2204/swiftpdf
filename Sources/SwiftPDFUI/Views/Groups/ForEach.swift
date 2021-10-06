public struct ForEach<Data, Content>: View where Data: RandomAccessCollection, Content: View {
    let data: Data
    let content: (Data.Element) -> Content
    
    public init(_ data: Data, @ViewBuilder content: @escaping (Int) -> Content) where Data == Range<Int> {
        self.data = data
        self.content = content
    }
    
    public init(_ data: Data, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.content = content
    }
}

extension ForEach: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
        data.forEach { dataElement in
            content(dataElement).unwrapped().buildTree(parent)
        }
    }
}
