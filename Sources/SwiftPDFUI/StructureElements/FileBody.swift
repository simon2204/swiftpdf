import Foundation

struct FileBody {
	var objects: [ExpressibleAsPDFData]
	
	var catalogReference: IndirectReference<Catalog>
	
	init(catalog: IndirectObject<Catalog>) {
		self.objects = [catalog]
		self.catalogReference = catalog.reference
	}
	
	mutating func appendObject<Object: ExpressibleAsPDFData>(_ indirectObject: IndirectObject<Object>) {
		indirectObject.objectNumber = objects.count
		self.objects.append(indirectObject)
	}
}
