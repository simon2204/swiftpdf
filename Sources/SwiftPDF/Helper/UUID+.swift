import Foundation

fileprivate let uppercase = true
fileprivate let radix = 16

extension UUID {
    var uuidHex: String {
        [String(uuid.0, radix: radix, uppercase: uppercase),
         String(uuid.1, radix: radix, uppercase: uppercase),
         String(uuid.2, radix: radix, uppercase: uppercase),
         String(uuid.3, radix: radix, uppercase: uppercase),
         String(uuid.4, radix: radix, uppercase: uppercase),
         String(uuid.5, radix: radix, uppercase: uppercase),
         String(uuid.6, radix: radix, uppercase: uppercase),
         String(uuid.7, radix: radix, uppercase: uppercase),
         String(uuid.8, radix: radix, uppercase: uppercase),
         String(uuid.9, radix: radix, uppercase: uppercase),
         String(uuid.10, radix: radix, uppercase: uppercase),
         String(uuid.11, radix: radix, uppercase: uppercase),
         String(uuid.12, radix: radix, uppercase: uppercase),
         String(uuid.13, radix: radix, uppercase: uppercase),
         String(uuid.14, radix: radix, uppercase: uppercase),
         String(uuid.15, radix: radix, uppercase: uppercase)].joined()
    }
}
