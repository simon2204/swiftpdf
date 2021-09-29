import SwiftPDF

public final class SwiftUIPDFPage: PDFPage {
    
	private let tree: Tree
	
	private var rootView: Node {
		tree.root
	}
    
	public init<Content>(rootView: Content) where Content: View {
		let drawable = RootDrawable()
		let node = Node(drawable)
		rootView.unwrapped().buildTree(node)
		self.tree = Tree(root: node)
        super.init()
    }
    
	public override func draw(in context: PDFGraphicsContext) {
        
    }
}

extension SwiftUIPDFPage: CustomStringConvertible {
	public var description: String {
		tree.description
	}
}
