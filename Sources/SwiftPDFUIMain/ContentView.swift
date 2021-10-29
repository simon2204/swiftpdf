import SwiftPDFUI

struct ContentView: View {
	var body: some View {
		HStack {
			Rectangle()
				.fill(.red)
			Rectangle()
				.stroke(.green, lineWidth: 20)
			
			RoundedRectangle(cornerRadius: 50)
			
			ZStack {
				Circle()
					.fill(.blue)
				Circle()
					.stroke(.red)
			}
			.frame(width: 50, height: 50)
		}
	}
}


