import SwiftPDFUI

struct SuccessTag: View {
	
	private let fontColor = Color(red: 0.31, green: 0.6, blue: 0.18)
	
	var body: some View {
		Text("Erfolgreich".uppercased())
			.foregroundColor(fontColor)
			.padding(.vertical, 4)
			.padding(.horizontal, 2)
			.background(content: TagBackground())
			.padding(1)
	}
}

private struct TagBackground: View {
	private let backgroundColor = Color(red: 0.97, green: 1, blue: 0.93)
	private let borderColor = Color(red: 0.75, green: 0.91, blue: 0.6)
	
	private let cornerRadius = 2.0
	
	var body: some View {
		ZStack {
			RoundedRectangle(cornerRadius: cornerRadius)
				.fill(backgroundColor)
			RoundedRectangle(cornerRadius: cornerRadius)
				.stroke(borderColor)
		}
	}
}
