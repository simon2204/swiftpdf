import Foundation

/// A one-line header identifying the version of the PDF specification to which the PDF file conforms.
struct FileHeader: ExpressibleAsPDFData {
    var pdfData: Data {
        // The file header consist of “%PDF–1.n” or “%PDF–2.n” followed by a single EOL marker,
        // where ‘n’ is a single digit number between 0 (30h) and 9 (39h)
        "%PDF-2.0"
        + Whitespace.lineFeed.rawValue
        // If the PDF file contains binary data,
        // the header line is immediately followed by a comment line
        // containing at least four binary characters–that is,
        // characters whose codes are 128 or greater.
        // This ensures proper behaviour of file transfer applications
        // that inspect data near the beginning of a file
        // to determine whether to treat the file’s contents as text or as binary.
        + "%"
        + (128...131)
        // New line for data coming after the `FileHeader`.
        + Whitespace.lineFeed.rawValue
    }
}
