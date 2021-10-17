import SwiftPDFUI

struct ContentView: View {
	var body: some View {
		Text("Hallo, Welt! Wie geht es dir?")
			.padding(1)
			.border(color: .gray, width: 1)
			.frame(width: 100, height: 20)
			.border(color: .red, width: 1)
	}
}
