/// Type erasure.
struct AnyPDFObject: ExpressibleAsPDFString {
    private let wrappedValue: ExpressibleAsPDFString
    
    init<WrappedValue>(_ object: WrappedValue) where WrappedValue: ExpressibleAsPDFString {
        self.wrappedValue = object
    }
    
    var pdfString: String {
        wrappedValue.pdfString
    }
}
