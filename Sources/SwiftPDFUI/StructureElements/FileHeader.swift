import Foundation

struct FileHeader {
    var data: Data {
        "%PDF–2.0"
        + Whitespace.crlf
    }
}
