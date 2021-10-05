import SwiftPDFUI

struct ContentView: View {
	
	let colors: [Color] = [.green, .blue, .pink]
	
	var body: some View {
		VStack {
		
			VerticallyStackedColors(colors: colors)
				.padding()
			
			HStack {
				VStack {
					VStack {
						Color.purple
						Color.yellow
					}
					Color.mint
				}
				Color.orange
				Color.teal
			}
			.padding(45)
			
			HStack {
				Color.red
				Color.indigo
				Color.yellow.frame(width: 400)
			}
		}
		.padding()
	}
}

struct VerticallyStackedColors: View {
	let colors: [Color]
	var body: some View {
		VStack(spacing: 20) {
			ForEach(colors) { color in
				color
			}
		}
	}
}
