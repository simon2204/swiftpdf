import Foundation

extension Double: PDFObject {
    var pdfValue: Data {
        "\(self)"
    }
}
