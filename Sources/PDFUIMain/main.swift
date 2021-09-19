@testable import SwiftPDFUI
import Foundation

let desktop = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftPDF.pdf")

let document = Document()

let page = document.makePage(mediaBox: Rectangle(lowerLeftX: 0, lowerLeftY: 0, upperRightX: 200, upperRightY: 600))
let page2 = document.makePage(mediaBox: Rectangle(lowerLeftX: 0, lowerLeftY: 0, upperRightX: 400, upperRightY: 600))

let documentData = document.create()

try documentData.write(to: desktop)
