import Foundation

public final class PDFPage {
	/// Returns the PDFDocument object with which this page is associated.
	public let document: PDFDocument
	
	let page: Page
	
	init(document: PDFDocument, page: Page) {
		self.document = document
		self.page = page
	}
	
	private var usedFonts = [Font : Name]()
	
	/// Returns the resource name for the current font.
	private func fontResourceName(for font: Font) -> Name {
		if let resourceName = usedFonts[font] {
			return resourceName
		}
		
		let resourceName = Name("F\(usedFonts.count)")
		
		usedFonts[font] = resourceName
		
		return resourceName
	}
	
	public func addText(_ text: PDFText) {
		let fontKeys = page.resources.font.keys
		let fontResource = fontResourceName(for: text.font.value)
		
		if !fontKeys.contains(fontResource) {
			let fontReference = document.createReference(for: text.font.value)
			page.resources.font[fontResource] = fontReference
		}
		
		let textStream = TextStream(
			text: text.text,
			color: text.color.value,
			position: text.position,
			scale: text.fontSize,
			fontResource: fontResource)
		
		let anyStream = AnyStream(textStream)
		let textStreamReference = document.createReference(for: anyStream)
		page.contents.append(textStreamReference)
	}
	
	public func rotateClockwise() {
		guard let degree = page.rotate else {
			page.rotate = 90; return
		}
		
		page.rotate = degree + 90
		
		if degree == 360 {
			page.rotate = nil
		}
	}
}
