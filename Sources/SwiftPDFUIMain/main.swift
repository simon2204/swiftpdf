import SwiftPDFUI
import SwiftPDF
import Foundation

let page = Page(rootView: ContentView())

let document = PDFDocument()

document.appendPage(page)

let desktopURL = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftBeta.pdf")

let data = document.dataRepresentation()

try data.write(to: desktopURL)
