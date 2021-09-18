@testable import SwiftPDFUI
import Foundation

extension Data {
    func hexEncodedString() -> String {
        return map { String(format: "%02hhx", $0) }.joined()
    }
}

let test = "Hallo"

let data = Data(test.utf8)

print(data.hexEncodedString())
