import Foundation

struct NamedObject: PDFObject {
    let name: String

    var pdfData: Data {
        "/\(name)".data
    }
    
//    var pdfData: Data {
//        if let object = value as? NamedObject {
//            return "\(name) \(object.name)"
//        } else {
//            return "\(name) " + value.pdfData
//        }
//    }
}

extension NamedObject: Hashable { }
