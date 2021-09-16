import Foundation

/// Types that can be expressed as human-readable format in a PDF's underlying data structure.
///
/// By comparing Swift's integer literal to that of a PDF's,
/// there is no difference in the representation,
/// but there is a difference when using `Array`s.
/// In Swift an `Array` literal is expressed
/// by an opening square bracket ([),
/// followed by objects separated by commas (,)
/// with optional whitespaces in between
/// and a trailing closing square bracket (]).
/// ```swift
/// [1, 5, 24, 19] // Swift's syntax of an `Array`.
/// ```
/// In PDFs this `Array` will need to have a slightly different representation,
/// which looks similar, but objects in a PDF-`Array` are seperated by whitespaces instead.
/// ```
/// [1 5 24 19] // PDF's syntax of an `Array`.
/// ```
/// For this reason objects shall implement the `ExpressibleAsPDFString` protocol,
/// when they can be expressed as a human readable text.
///
protocol ExpressibleAsPDFString: ExpressibleAsPDFData {
    var pdfString: String { get }
}

extension ExpressibleAsPDFString {
    var pdfData: Data {
        Data(pdfString.utf8)
    }
}
