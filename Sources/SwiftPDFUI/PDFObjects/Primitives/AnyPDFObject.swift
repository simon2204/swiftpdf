/// Type erasure.
struct AnyPDFObject: ExpressibleAsPDFObject {
    private let wrappedValue: ExpressibleAsPDFObject
    
    init<WrappedValue>(_ object: WrappedValue) where WrappedValue: ExpressibleAsPDFObject {
        self.wrappedValue = object
    }
    
    var pdfRepresentation: String {
        wrappedValue.pdfRepresentation
    }
}
