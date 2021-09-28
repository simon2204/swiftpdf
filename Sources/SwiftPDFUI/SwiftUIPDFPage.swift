import SwiftPDF

final class SwiftUIPDFPage<Content: View>: PDFPage {
    
    private var rootView: Content
    
    public init(rootView: Content) {
        self.rootView = rootView
        super.init()
    }
    
    override func draw(in context: PDFGraphicsContext) {
        
    }
}
