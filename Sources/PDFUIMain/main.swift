@testable import SwiftPDFUI
import Foundation

let desktop = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftPDF.pdf")

let rectangle = Rectangle(lowerLeftX: 0, lowerLeftY: 0, upperRightX: 700, upperRightY: 800)

let catalog = Catalog()

let indirectCatalog = IndirectObject(referencing: catalog)

let pages = Pages()

let indirectPages = IndirectObject(referencing: pages)

let page = Page(parent: indirectCatalog.reference, mediaBox: rectangle)

let indirectPage = IndirectObject(referencing: page)

indirectPages.object.kids = [indirectPage.reference]

indirectCatalog.object.pages = indirectPages.reference

var body = FileBody(catalog: indirectCatalog)

body.appendObject(indirectPage)

let document = PDFDocument(body: body)

try document.create().write(to: desktop)
