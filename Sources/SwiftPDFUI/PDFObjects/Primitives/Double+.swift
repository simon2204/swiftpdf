import Foundation

extension Double: PDFObject {
    var pdfData: Data {
        String(self).pdfData
    }
}
