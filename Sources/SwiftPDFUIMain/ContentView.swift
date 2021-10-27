import SwiftPDFUI

struct ContentView: View {
	var body: some View {
		HStack {
			VStack(spacing: 0) {
				Text("Hallo und so und so!")
				Text("Hallo und so und so!")
				Text("Hallo und so und so!")
				Spacer()
			}
			Spacer()
		}
		.border(color: .blue)
		.padding(.vertical, 20)
		.padding(.horizontal, 50)
		.border(color: .red)
	}
}
