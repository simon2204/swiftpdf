import SwiftPDFUI

struct Overview: View {
	let name: String
	let creationDate: String
	let taskName: String
	let result: String
	
	private let fontSize = 10.0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 16) {
	
			InfoLine {
				HStack {
					Text("Name:")
					Text(name)
				}
			} second: {
				HStack {
					Text("Erstellt:")
					Text(creationDate)
				}
			}
			
			InfoLine {
				HStack {
					Text("Praktikumsaufgabe:")
					Text(taskName)
				}
			} second: {
				HStack {
					Text("Erfolgreiche Testfälle:")
					Text(result)
				}
			}
		}
	}
}

private struct InfoLine<First, Second>: View where First: View, Second: View {
	let first: () -> First
	let second: () -> Second
	
	var body: some View {
		HStack {
			first()
			Spacer()
			second()
			Spacer(minLength: 0)
			Spacer(minLength: 0)
			Spacer(minLength: 0)
		}
	}
}
