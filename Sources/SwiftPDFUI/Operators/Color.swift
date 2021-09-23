struct Color: Equatable {
    var colorSpace: ColorSpace
    var operation: InkOperation
}

extension Color: ExpressibleAsPDFString {
    var pdfString: String {
        switch operation {
        case .stroke:
            switch colorSpace {
            case let .deviceGray(g):
                return "\(g) G"
                
            case let .deviceRGB(r, g, b):
                return "\(r) \(g) \(b) RG"
                
            case let .deviceCMYK(c, m, y, k):
                return "\(c) \(m) \(y) \(k) K"
            }
            
        case .fill:
            switch colorSpace {
            case let .deviceGray(g):
                return "\(g) g"
                
            case let .deviceRGB(r, g, b):
                return "\(r) \(g) \(b) rg"
                
            case let .deviceCMYK(c, m, y, k):
                return "\(c) \(m) \(y) \(k) k"
            }
        }
    }
}
