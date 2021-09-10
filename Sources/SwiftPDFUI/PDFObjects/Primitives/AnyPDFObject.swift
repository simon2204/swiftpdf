import Foundation

struct AnyPDFObject: PDFObject {
    private let wrappedValue: PDFObject
    
    init<WrappedValue>(_ object: WrappedValue) where WrappedValue: PDFObject {
        self.wrappedValue = object
    }
    
    var pdfData: Data {
        wrappedValue.pdfData
    }
}
