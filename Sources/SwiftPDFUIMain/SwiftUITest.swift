import SwiftPDFUI

struct SwiftUITest: View {
	
	let someColor = [Color.yellow, Color.yellowGreen, Color.crimson]

	var body: some View {
		HStack {
			
			Color.yellow.frame(width: 100)
			Color.yellow.frame(width: 100)
			
			HStack {
				Color.yellow.frame(width: 100)
				Color.green.frame(width: 100)
				Color.green.frame(width: 100)
				
				HStack {
					Color.yellow.frame(width: 100)
					Color.green.frame(width: 100)
					Color.green.frame(width: 100)
				}
			}
		}
	}
}
