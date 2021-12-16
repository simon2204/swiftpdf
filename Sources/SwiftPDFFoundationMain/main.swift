import SwiftPDFFoundation
import Foundation

#if os(Linux)
let desktop = URL(fileURLWithPath: "/home/simon/Schreibtisch/SwiftPDF.pdf")
#else
let desktop = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftPDF.pdf")
#endif

let document = PDFDocument()

class DinA4PDFPage: PDFPage {
	override init() {
		let width = 210 * 72 * 0.0393701
		let height = 297 * 72 * 0.0393701
		super.init(width: width, height: height)
	}
}

class BezierCurve: DinA4PDFPage {
	override func draw(in context: PDFGraphicsContext) {
		let topLeft = PDFPoint(x: 0, y: size.height)
		let topRight = PDFPoint(x: size.width, y: size.height)
		let bottomRight = PDFPoint(x: size.width, y: 0)
		
		context.saveGState()
		
		context.setStrokeColor(.green)
		
		context.move(to: .zero)
		
		context.addCurve(to: topRight, control1: topLeft, control2: bottomRight)
		
		context.strokePath()
		
		context.restoreGState()
	}
}

class Ellipse: DinA4PDFPage {
	override func draw(in context: PDFGraphicsContext) {
		context.saveGState()
		
		context.setFillColor(.aquaMarine)
		
		let rect = PDFRect(x: 50, y: 50, width: 200, height: 700)
		
		context.addEllipse(in: rect)
		
		context.fillPath()
		
		context.restoreGState()
		
		context.setFontSize(20)
		
		context.showText("uhawguhaughg", at: .init(x: 60, y: 60))
	}
}

class Triangle: DinA4PDFPage {
	
	override func draw(in context: PDFGraphicsContext) {
		
		
		context.setFillColor(.gold)
		context.setStrokeColor(.blue)
		
		context.move(to: .init(x: 150, y: 150))
		
		context.addLine(to: .init(x: 50, y: 50))
		
		context.addLine(to: .init(x: 30, y: 10))
		
		context.closePath()
		
		context.fillPath()
		
		
		context.move(to: .init(x: 150, y: 150))
		
		context.addLine(to: .init(x: 50, y: 50))
		
		context.addLine(to: .init(x: 30, y: 10))
		
		context.closePath()
		
		context.strokePath()
	}
}

let page = Ellipse()
let page2 = BezierCurve()

document.appendPage(page)
document.appendPage(page2)
document.appendPage(Triangle())

let documentData = document.dataRepresentation()

try documentData.write(to: desktop)
