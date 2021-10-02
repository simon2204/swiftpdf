import SwiftPDFUI

struct SwiftUITest: View {
	
	let someColors: [Color] = [.greenYellow, .indigo, .tomato]
	
	var body: some View {
		HStack {
			Color.blanchedAlmond
			
			HStack {
				Color.aquaMarine
				Color.red
			}
			
			ForEach(someColors) { color in
				color.padding(15)
			}
			
			HStack(spacing: 5) {
				Color.gold
				Color.goldenRod
			}
			.padding(25)
		}
		.padding(20)
	}
}
