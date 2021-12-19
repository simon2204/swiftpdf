@testable import SwiftPDF

class DebugTree {
    
    private let rootNode: JustifiableNode
    
    init<V: View>(root: () -> V) {
        rootNode = RootNode()
        root().unwrapped().buildTree(rootNode)
        rootNode.justifyBounds()
        rootNode.justify(proposedWidth: 500, proposedHeight: 500)
        rootNode.justify(x: 0)
        rootNode.justify(y: 0)
    }
    
    func firstNode<Node>(ofType type: Node.Type) -> Node? where Node: JustifiableNode {
        firstNode(ofType: type, in: rootNode)
    }
    
    private func firstNode<Node>(ofType type: Node.Type, in root: JustifiableNode) -> Node? {
        for child in root.children {
        
            if let node = firstNode(ofType: type, in: child) {
                return node
            }
            
            if let node = child as? Node {
                return node
            }
        }
        
        return nil
    }
}
