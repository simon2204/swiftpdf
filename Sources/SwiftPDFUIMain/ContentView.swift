import SwiftPDFUI

struct ContentView: View {
	var body: some View {
		VStack {
			Text("Hey, guck mal, wie toll! :D")
				.size(20)
				.padding()
				.border()
			
			Text("Mit freundlichen Grüßen, Simon Schöpke")
				.size(20)
		}
		.padding()
		.border()
	}
}
