import Foundation

extension String {
    var data: Data {
        self.data(using: .utf8)!
    }
}

extension String: PDFObject {
    var pdfData: Data {
        "(" + data + ")"
    }
}
