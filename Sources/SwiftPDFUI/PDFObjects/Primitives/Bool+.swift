import Foundation

extension Bool: PDFObject {
    var pdfValue: Data {
        self ? "true" : "false"
    }
}
