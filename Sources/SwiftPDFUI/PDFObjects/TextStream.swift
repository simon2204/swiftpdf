import Foundation

struct TextStream {
	let text: HexadecimalString
	
	let color: Color
	
	let position: PDFPoint
	
	let scale: Double
	
	let fontResource: Name
}

extension TextStream: ExpressibleAsPDFStream {
	var pdfStream: [ExpressibleAsPDFData] {
		var objects = [ExpressibleAsPDFData]()
		
		// Begin textobject
		let begin = TextObject.begin
		objects.append(begin)
		
		// Positioning
		let x = position.x
		let y = position.y
		let position = TextPositioning.move(dx: x, dy: y)
		objects.append(position)
		
		// Set font and size
		let textState = TextState.font(
			fontResource: fontResource,
			scaleFactor: scale)
		objects.append(textState)
		
		// Set text fill color
		objects.append(color)
		
		// Append text
		let text = TextShowing.show(text)
		objects.append(text)
		
		// End textobject
		let end = TextObject.end
		objects.append(end)
		
		return objects
	}
}
