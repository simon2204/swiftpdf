final class Tree {
    let root: Node
    
    init(root: Node) {
        self.root = root
    }
}

final class Node {
    
    let content: PrimitiveView
    
    var children: [Node]
    
    init(_ content: PrimitiveView) {
        self.content = content
        self.children = []
    }
}
