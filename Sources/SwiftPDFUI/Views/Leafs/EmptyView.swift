public struct EmptyView: View {
    public init() {}
}

extension EmptyView: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {}
}
