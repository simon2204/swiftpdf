/// Types that can be expressed as raw data in a PDF's underlying data structure.
protocol ExpressibleAsPDFData {
    var pdfData: Data { get }
}
