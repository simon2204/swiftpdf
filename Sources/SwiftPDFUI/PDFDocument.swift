import Foundation

struct PDFDocument {
	var body: FileBody
	
	func create() -> Data {
		var data = FileHeader().pdfData
		
		var table = CrossReferenceTable()
		
		for object in body.objects {
			let offset = data.count
			data.append(object.pdfData)
			table.append(entry: .init(offset: offset))
		}
        
        let tableOffset = data.count
		
		data.append(table.pdfData)
		
		let trailer = FileTrailer(
			size: table.entryCount,
			root: body.catalogReference,
			id: ["Hallo"],
			crossReferenceOffset: tableOffset)
		
		data.append(trailer.pdfData)
		
		return data
	}
}
