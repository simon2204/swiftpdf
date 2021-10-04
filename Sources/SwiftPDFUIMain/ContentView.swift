import SwiftPDFUI

struct ContentView: View {
	var body: some View {
		HStack {
			HStack {
				Color.blue
				Color.green.frame(width: 100)
				Color.green.frame(width: 100)
			}
			Color.red
			Color.yellow.frame(width: 100)
		}
	}
}
