import SwiftPDF

public final class Page: PDFPage {
	
	private let rootDrawable: RootDrawable
    
	public init<Content>(rootView: Content) where Content: View {
		let mm = 72 * 0.0393701
		let width = 210 * mm
		let height = 297 * mm
		self.rootDrawable = RootDrawable(pageSize: Size(width: width, height: height))
		rootView.unwrapped().buildTree(rootDrawable)
        super.init(width: width, height: height)
    }
    
	public override func draw(in context: PDFGraphicsContext) {
		_ = rootDrawable.justifyBounds()
		rootDrawable.layoutSubViews()
        rootDrawable.draw(in: context)
    }
}
