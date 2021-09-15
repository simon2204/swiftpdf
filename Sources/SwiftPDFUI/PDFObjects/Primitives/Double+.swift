import Foundation

extension Double: PDFObject {
    var pdfData: Data {
        "\(self)"
    }
}
