import SwiftPDF
import Foundation

var document = Document {
    ContentView()
}

let desktopURL = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftBeta.pdf")

let data = document.createData()

try data.write(to: desktopURL)
