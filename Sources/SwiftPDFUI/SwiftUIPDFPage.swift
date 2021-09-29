import SwiftPDF

public final class SwiftUIPDFPage: PDFPage {
    
	private let rootDrawable = RootDrawable()
    
	public init<Content>(rootView: Content) where Content: View {
		rootView.unwrapped().buildTree(rootDrawable)
        super.init()
    }
    
	public override func draw(in context: PDFGraphicsContext) {
        
    }
}

extension SwiftUIPDFPage: CustomStringConvertible {
	public var description: String {
        rootDrawable.description
	}
}
