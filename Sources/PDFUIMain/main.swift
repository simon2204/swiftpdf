import SwiftPDFUI
import Foundation

let desktop = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftPDF.pdf")

let document = PDFDocument()

let page = document.appendPage(dimentions: PDFSize(width: 200, height: 400))
var text = PDFText("Hallo", font: PDFFont.helvetica)
text.fontSize = 10
text.color = .blue
text.position = .init(x: 20, y: 20)

page.addText(text)

let page2 = document.appendPage(dimentions: PDFSize(width: 400, height: 600))
page2.rotateClockwise()
page2.rotateClockwise()

let documentData = document.dataRepresentation

try documentData.write(to: desktop)
