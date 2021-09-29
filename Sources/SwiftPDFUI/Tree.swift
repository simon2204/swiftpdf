final class Tree {
    let root: Node
    
    init(root: Node) {
        self.root = root
    }
}

final class Node {
    
    let content: Drawable
    
    var children: [Node]
    
    init(_ content: Drawable) {
        self.content = content
        self.children = []
    }
}

extension Node: CustomStringConvertible {
	var description: String {
		"Node(\(content), children: \(children)"
	}
}

extension Tree: CustomStringConvertible {
	var description: String {
		root.description
	}
}
