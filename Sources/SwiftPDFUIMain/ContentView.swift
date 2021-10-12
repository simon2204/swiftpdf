import SwiftPDFUI

//struct ContentView: View {
//	var body: some View {
//		HStack(spacing: 0) {
//			Color.blue.frame(width: 50)
//			Spacer(minLength: 50)
//			Color.blue.frame(width: 50)
//			Spacer(minLength: 100)
//			Color.blue.frame(width: 50)
//		}.frame(width: 300)
//	}
//}

//struct ContentView: View {
//	var body: some View {
//		HStack(spacing: 0) {
//			Color.blue
//			Spacer(minLength: 0)
//			Color.blue.frame(width: 50)
//			Spacer(minLength: 0)
//			Color.blue.frame(width: 50)
//		}
//	}
//}

struct ContentView: View {
	var body: some View {
		VStack(spacing: 0) {
			HStack(spacing: 0) {
				Color.blue.frame(height: 200)
				Spacer()
				Color.green.frame(height: 200)
			}.border()
			
			Color.red
			
			Spacer()
		}
	}
}
