import SwiftPDF

public final class Page: PDFPage {
	
	private let rootDrawable: RootDrawable
    
	public init<Content>(rootView: Content) where Content: View {
		let mm = 72 * 0.0393701
		let width = 210 * mm
		let height = 297 * mm
		
		self.rootDrawable = RootDrawable(pageSize: Size(width: width, height: height))
		rootView.unwrapped().buildTree(rootDrawable)
		_ = rootDrawable.justifyBounds()
		
		rootDrawable.justify(
			proposedWidth: width,
			proposedHeight: height
		)
		rootDrawable.justify(x: 0)
		rootDrawable.justify(y: 0)
		rootDrawable.nodeDidJustify()
		
		super.init(width: rootDrawable.width, height: rootDrawable.height)
    }
    
	public override func draw(in context: PDFGraphicsContext) {
        rootDrawable.draw(in: context)
    }
}
