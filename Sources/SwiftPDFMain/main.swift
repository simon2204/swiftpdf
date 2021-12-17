import SwiftPDF
import Foundation

var document = Document {
    ContentView()
    ContentView()
    Color.gray
}
    
document.pageSize = .preferred(.init(width: 500, height: 500))

let desktopURL = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftBeta.pdf")

let data = document.createData()

try data.write(to: desktopURL)
