import SwiftPDFFoundation
import Foundation

final class Page: PDFPage {
    
	private let rootNode: JustifiableNode
    
    init(rootNode: JustifiableNode, size: PageSize) {
        
        self.rootNode = rootNode
        
		rootNode.justifyBounds()
        
        switch size {
        case .fixed(let size):
            
            rootNode.justify(
                proposedWidth: size.width,
                proposedHeight: size.height
            )
                        
            rootNode.justify(x: (size.width - rootNode.width) / 2)
            rootNode.justify(y: (size.height - rootNode.height) / 2)
            
            super.init(width: size.width, height: size.height)
            
        case .preferred(let size):
            
            rootNode.justify(
                proposedWidth: size.width,
                proposedHeight: size.height
            )
            
            rootNode.justify(x: 0)
            rootNode.justify(y: 0)
            
            super.init(width: rootNode.width, height: rootNode.height)
        }
        
        rootNode.nodeDidJustify()
    }
    
	public override func draw(in context: PDFGraphicsContext) {
        rootNode.draw(in: context)
    }
}

public enum PageSize {
    case fixed(Size)
    case preferred(Size)
    
    public var size: Size {
        switch self {
        case .fixed(let size):
            return size
        case .preferred(let size):
            return size
        }
    }
}
