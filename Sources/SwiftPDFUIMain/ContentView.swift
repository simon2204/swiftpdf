import SwiftPDFUI

struct ContentView: View {

	var body: some View {
		VStack(spacing: 0) {
			Color.red.frame(height: 200)
			Color.green.frame(height: 200)
			
			GeometryReader { frame -> Color in
				print(frame)
				
				return Color.blue
			}
			
			Spacer(minLength: 0)
		}
	}
}
