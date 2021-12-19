import SwiftPDF
import Foundation

var document = Document {
    Seperator(title: "Überschrift")
    Seperator()
}

let desktopURL = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftBeta.pdf")

let data = document.createData()

try data.write(to: desktopURL)
