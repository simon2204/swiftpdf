import SwiftPDF

public final class Page: PDFPage {
    
	private let rootDrawable = RootDrawable()
    
	public init<Content>(rootView: Content) where Content: View {
		rootView.unwrapped().buildTree(rootDrawable)
        
        let width: Double = 210 * 72 * 0.0393701
        let height: Double = 297 * 72 * 0.0393701
		
		rootDrawable.size = Size(width: width, height: height)
        
        super.init(width: width, height: height)
    }
    
	public override func draw(in context: PDFGraphicsContext) {
		_ = rootDrawable.getBoundary()
		rootDrawable.layoutSubViews()
		rootDrawable.nodeWillDrawSelf()
        rootDrawable.draw(in: context)
		rootDrawable.nodeDidDrawSelf()
    }
}
