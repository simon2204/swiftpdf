import Foundation

enum Whitespace {
    /// Null (NUL)
    static let null: Data = 0x00
    /// HORIZONTAL TAB (HT)
    static let horizontalTab: Data = "\t"
    /// LINE FEED (LF)
    static let lineFeed: Data = "\n"
    /// FORM FEED (FF)
    static let formFeed: Data = 0x0C
    /// CARRIAGE RETURN (CR)
    static let carriageReturn: Data = "\r"
    /// CARRIAGE RETURN and LINE FEED (CRLF)
    static let crlf: Data = "\r\n"
    /// SPACE (SP)
    static let space: Data = " "
}
