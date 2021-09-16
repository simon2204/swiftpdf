import Foundation

/// Types that can be expressed as binary data in a PDF's underlying data structure.
protocol ExpressibleAsPDFData {
    var pdfData: Data { get }
}
