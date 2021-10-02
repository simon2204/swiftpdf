extension Color: View {}

extension Color: PrimitiveView {
    func buildTree(_ parent: JustifiableNode) {
        let drawable = ColorDrawable(color: self)
        parent.add(child: drawable)
    }
}
