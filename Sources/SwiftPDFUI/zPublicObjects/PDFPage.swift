import Foundation

open class PDFPage {
	
	/// Dimentions of the page.
	public var size: PDFSize
	
	/// Layout of the page.
	open var layout = Layout.vertical
	
	/// Specifies whether the page should rotate by 180 degrees.
	open var invertLayout = false
	
	/// Initializes a ``PDFPage`` with a specific size.
	///
	/// - Parameter size: Size of the page in user space units.
	public init(size: PDFSize) {
		self.size = size
	}
	
	/// Initializes a ``PDFPage`` with a specific size.
	///
	/// - Parameter size: Size of the page in user space units.
	public init(width: Double, height: Double) {
		self.size = PDFSize(width: width, height: height)
	}
	
	/// Initializes a ``PDFPage`` with a size of zero.
	///
	/// - Parameter size: Size of the page in user space units.
	public init() {
		self.size = .zero
	}
	
	open func draw(in context: PDFGraphicsContext) {
		// Drawing content
	}
	
	/// Creates the contents of this page.
	///
	/// - Note: Before any content is visible on this page, you must call this function.
	///
	/// - Returns: PDF graphics context stream.
	func create() -> PageContent {
		let context = PDFGraphicsContext()
		
		draw(in: context)
		
		return PageContent(
			stream: AnyStream(context),
			fonts: context.appliedFonts
		)
	}
	
	public enum Layout {
		case vertical
		case horizontal
	}
	
	struct PageContent {
		let stream: AnyStream
		let fonts: Set<PDFFont>
	}
}
