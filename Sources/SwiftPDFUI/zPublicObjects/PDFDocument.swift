import Foundation

public final class PDFDocument {
	
	/// Indirect objects of the ``PDFDocument``s body.
    private var bodyObjects = [ExpressibleAsPDFData]()
    
    private let catalogReference: IndirectReference<Catalog>
    
    private let pages: Pages
	
	/// Inilializes a new `PDFDocument`.
    public init() {
        let pages = Pages()
		
        let indirectPages = IndirectObject(
			referencing: pages,
			objectNumber: &indirectObjectCount)
        bodyObjects.append(indirectPages)
        
        let catalog = Catalog(pages: indirectPages.reference)
		
        let indirectCatalog = IndirectObject(
			referencing: catalog,
			objectNumber: &indirectObjectCount)
        bodyObjects.append(indirectCatalog)
        
        self.catalogReference = indirectCatalog.reference
        self.pages = pages
    }
	
	// MARK: - PDF Header Information
	
	/// File header of this document.
	private static let header = FileHeader()
	
	/// The major version of the document.
	public var majorVersion: Int {
		Self.header.minor
	}
	
	/// The minor version of the document.
	public var minorVersion: Int {
		Self.header.minor
	}
	
	// MARK: - Append Pages
	
	public func appendPage(_ pdfPage: PDFPage) {
		let mediaBox = Rectangle(
			lowerLeftX: 0,
			lowerLeftY: 0,
			upperRightX: pdfPage.size.width,
			upperRightY: pdfPage.size.height)
		
		let pdfPageContent = pdfPage.create()
		
		let page = Page(parent: catalogReference, mediaBox: mediaBox)
		
		pages.kids.append(makeReference(for: page))
		
		page.contents.append(makeReference(for: pdfPageContent.stream))
		
		for pdfFont in pdfPageContent.fonts {
			addFont(pdfFont, to: page)
		}
	}
	
	// MARK: - Font Resource Management
	
	/// Contains all fonts that have already been added to the file body.
	private var fontReferences = [PDFFont : IndirectReference<Font>]()
	
	/// Returns an indirect reference for a font.
	///
	/// Uses caching behaviour to avoid duplicates of font resources.
	///
	/// - Parameter font: Font to get an `IndirectReference` for.
	/// - Returns: IndirectReference for the given font.
	private func getFontReference(for font: PDFFont) -> IndirectReference<Font> {
		
		// Return a font reference if one was already created.
		if let fontReference = self.fontReferences[font] {
			return fontReference
		}
		
		// Create an indirectObject..
		let indirectFont = IndirectObject(
			referencing: font.value,
			objectNumber: &indirectObjectCount)
		
		// ..and append it to the document's file body.
		bodyObjects.append(indirectFont)
		
		// Add font reference to the `fontReferences` dictionary
		// because no reference has been created yet for the given font.
		let fontReference = indirectFont.reference
		fontReferences[font] = fontReference
		
		// Return the just created font reference.
		return fontReference
	}
	
	/// Adds a font as a resource to a page if the pages does not already contain the font resource.
	private func addFont(_ font: PDFFont, to page: Page) {
		let fontReference = getFontReference(for: font)
		page.resources.font[font.resourceName] = fontReference
	}
	
	// MARK: - Create PDF Data
	
	/// Returns a representation of the document as an Data object.
	public func dataRepresentation() -> Data {
		
		/// Creates file header data.
		var pdfData = Self.header.pdfData
		
		var table = CrossReferenceTable()
		
		var tableDataOffset = 0
		
		/// Creates file body data.
		func createBodyData() {
			for object in bodyObjects {
				let offset = pdfData.count
				pdfData.append(object.pdfData)
				table.append(entry: .init(offset: offset))
			}
		}
		
		/// Creates body data and cross reference table data.
		///
		/// - Returns: Byte offset for start of cross reference table data.
		///
		func createTableData() {
			tableDataOffset = pdfData.count
			pdfData.append(table.pdfData)
		}
		
		/// Creates the file trailer with the given table byte offset.
		///
		/// - Parameter tableOffset: Offset for the cross reference table in bytes.
		///
		func createTrailer() {
			let hexID = HexadecimalString(UUID())
			let trailer = FileTrailer(
				size: table.entryCount,
				root: catalogReference,
				id: [hexID, hexID],
				crossReferenceOffset: tableDataOffset)
			pdfData.append(trailer.pdfData)
		}
		
		createBodyData()
		createTableData()
		createTrailer()
			
		return pdfData
	}
	
	// MARK: - Create References
	
	private var indirectObjectCount = 1
	
	/// Creates an indirect object for a given object and returns its reference.
	///
	/// - Returns: IndirectReference for the given object.
	private func makeReference<Object: ExpressibleAsPDFData>(for object: Object) -> IndirectReference<Object> {
		let indirectObject = IndirectObject(referencing: object, objectNumber: &indirectObjectCount)
		bodyObjects.append(indirectObject)
		return indirectObject.reference
	}
}
