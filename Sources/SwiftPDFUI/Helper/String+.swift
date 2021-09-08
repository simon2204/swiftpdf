import Foundation

extension String {
    var data: Data {
        self.data(using: .utf8)!
    }
}
