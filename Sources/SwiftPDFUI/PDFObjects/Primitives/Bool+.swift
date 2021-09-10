import Foundation

extension Bool: PDFObject {
    var pdfData: Data {
        self ? "true" : "false"
    }
}
