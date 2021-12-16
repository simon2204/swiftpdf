/// Richtet Knoten entlang der vertikalen Achse aus.
class VerticalAxisJustifier: AxisJustifier {
    
    private let proposedWidth: Double
    
    init<Nodes: Collection>(nodes: Nodes, proposedWidth: Double, proposedHeight: Double) where Nodes.Element == JustifiableNode {
        self.proposedWidth = proposedWidth
        super.init(nodes: nodes, length: proposedHeight)
    }
    
    override func justifyNode(_ node: JustifiableNode, proposedLength: Double) {
        node.justify(proposedWidth: proposedWidth, proposedHeight: proposedLength)
    }
    
    override func nodeLength(_ node: JustifiableNode) -> Double {
        return node.height
    }
    
    override func nodeMinLength(_ node: JustifiableNode) -> Double {
        return node.minHeight
    }
    
    override func nodeMaxLength(_ node: JustifiableNode) -> Double {
        return node.maxHeight
    }
}
