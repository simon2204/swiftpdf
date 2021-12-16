struct Name: ExpressibleAsPDFString {
    let name: String

    init(_ name: String) {
        self.name = name
    }
    
    var pdfString: String {
        "/\(name.capitalizingFirstLetter())"
    }
}

extension Name: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        self.name = value
    }
}

extension Name: Hashable { }
