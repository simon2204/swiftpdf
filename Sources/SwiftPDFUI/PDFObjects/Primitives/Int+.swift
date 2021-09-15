import Foundation

extension Int: PDFObject {
    var pdfData: Data {
        "\(self)"
    }
}

extension Int {
    func formatted(integerLength: Int) -> String {
        self.formatted(.number.precision(.integerLength(integerLength)).grouping(.never))
    }
}
