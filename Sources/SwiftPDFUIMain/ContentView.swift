import SwiftPDFUI

struct ContentView: View {
	var body: some View {
		HStack {
			Color.green
			
			Spacer(minLength: 100)
			
			GeometryReader { geometry -> Color in
				print(geometry)
				return Color.blue
			}
			.frame(width: 150)
			
			Spacer(minLength: 50)
			
			GeometryReader { geometry -> Color in
				print(geometry)
				return Color.yellow
			}
			.frame(width: 100)
			
		}
	}
}
