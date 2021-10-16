import SwiftPDFUI

struct ContentView: View {
	
	let text = "Hallo    katze    \n Mein   "
	
	var body: some View {
		HStack {
			ForEach(0..<12) { count in
				Text("\(count) " + text)
					.frame(height: 50)
					.border()
			}
		}
	}
}

