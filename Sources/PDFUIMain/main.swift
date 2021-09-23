import SwiftPDFUI
import Foundation

let desktop = URL(fileURLWithPath: "/Users/simon/Desktop/SwiftPDFUI.pdf")

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
		
		let rect = PDFRect(x: 0, y: 0, width: 200, height: 200)
		
		context.addEllipse(in: rect)
		
		context.fillPath()
		
		context.restoreGState()
	}
}

let page = BezierCurve()
let page2 = Ellipse()

document.appendPage(page2)
document.appendPage(page)

let documentData = document.dataRepresentation()

let endTime = DispatchTime.now()

try documentData.write(to: desktop)
