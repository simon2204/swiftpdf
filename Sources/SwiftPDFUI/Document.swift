import Foundation

final class Document {
    private var bodyObjects: [ExpressibleAsPDFData] = []
    
    private let catalogReference: IndirectReference<Catalog>
    
    private let pages: Pages
    
    init() {
        let pages = Pages()
        let indirectPages = IndirectObject(referencing: pages)
        bodyObjects.append(indirectPages)
        
        let catalog = Catalog(pages: indirectPages.reference)
        let indirectCatalog = IndirectObject(referencing: catalog)
        bodyObjects.append(indirectCatalog)
        
        self.catalogReference = indirectCatalog.reference
        self.pages = pages
    }
    
    func makePage(mediaBox: Rectangle) -> Page {
        let page = Page(parent: catalogReference, mediaBox: mediaBox)
        let pageReference = createReference(for: page)
        pages.kids.append(pageReference)
        return page
    }
	
	func create() -> Data {
		var pdfData = FileHeader().pdfData
		
		var table = CrossReferenceTable()
		
		for object in bodyObjects {
			let offset = pdfData.count
			pdfData.append(object.pdfData)
			table.append(entry: .init(offset: offset))
		}
        
        let tableOffset = pdfData.count
		
		pdfData.append(table.pdfData)
        
        let uniqueID = UUID()
        let hexID = HexadecimalString(uniqueID)
		
		let trailer = FileTrailer(
			size: table.entryCount,
			root: catalogReference,
			id: [hexID, hexID],
			crossReferenceOffset: tableOffset)
		
		pdfData.append(trailer.pdfData)
		
		return pdfData
	}
    
    private func createReference<Object: ExpressibleAsPDFData>(for object: Object) -> IndirectReference<Object> {
        let indirectObject = IndirectObject(referencing: object)
        bodyObjects.append(indirectObject)
        return indirectObject.reference
    }
}
