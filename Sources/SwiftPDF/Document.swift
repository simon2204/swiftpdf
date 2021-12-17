import SwiftPDFFoundation
import Foundation

public struct Document {
    
    /// Millimeter
    private static let mm = 72 * 0.0393701
    
    /// Standard width of a DinA4 Paper.
    private static let width = 210 * mm
    
    /// Standard height of a DinA4 Paper.
    private static let height = 297 * mm
    
    private static let pageSize = PageSize.fixed(Size(width: width, height: height))
    
    private let content: PrimitiveView
    
    public var pageSize = Self.pageSize
    
    public init<Content>(@ViewBuilder content: () -> Content) where Content: View {
        self.content = content().unwrapped()
    }
    
    public func createData() -> Data {
        
        let root = RootNode()
        
        content.buildTree(root)
        
        let document = PDFDocument()
        
        for node in root.children {
            let page = Page(rootNode: node, size: pageSize)
            document.appendPage(page)
        }
    
        return document.dataRepresentation()
    }
}
