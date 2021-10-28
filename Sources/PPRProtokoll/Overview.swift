import SwiftPDFUI

struct Overview: View {
	let name: String
	let creationDate: String
	let taskName: String
	let result: String
	
	private let fontSize = 10.0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
	
			InfoLine(
				first: "Name: \(name)",
				second: "Erstellt: \(creationDate)"
			)
			
			InfoLine(
				first: "Praktikumsaufgabe: \(taskName)",
				second: "Erfolgreiche Testfälle: \(result)"
			)
		}
	}
}

private struct InfoLine: View {
	let first: String
	let second: String
	
	private let fontSize = 10.0
	
	var body: some View {
		HStack {
			Text(first)
				.fontSize(fontSize)
			
			Spacer()
			
			Text(second)
				.fontSize(fontSize)
			
			Spacer(minLength: 0)
			Spacer(minLength: 0)
			Spacer(minLength: 0)
		}
	}
}
