/// Richtet Knoten entlang der horizontalen Achse aus.
class HorizontalAxisJustifier: AxisJustifier {
    
    private let proposedHeight: Double
    
    init<Nodes: Collection>(nodes: Nodes, proposedWidth: Double, proposedHeight: Double) where Nodes.Element == JustifiableNode {
        self.proposedHeight = proposedHeight
        super.init(nodes: nodes, length: proposedWidth)
    }
    
    override func justifyNode(_ node: JustifiableNode, proposedLength: Double) {
        node.justify(proposedWidth: proposedLength, proposedHeight: proposedHeight)
    }
    
    override func nodeLength(_ node: JustifiableNode) -> Double {
        return node.width
    }
    
    override func nodeMinLength(_ node: JustifiableNode) -> Double {
        return node.minWidth
    }
    
    override func nodeMaxLength(_ node: JustifiableNode) -> Double {
        return node.maxWidth
    }
}
