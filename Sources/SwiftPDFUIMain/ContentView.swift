import SwiftPDFUI

struct ContentView: View {
	var body: some View {
        HStack(spacing: 0) {
            Color.green
                .frame(width: 200, height: 200)
            
            Color.red
                .padding(10)
                .border(color: Color.blue, width: 10)
                .frame(width: 200, height: 200)
            
            Text("Hallo, wie geht es dir?")
                .padding(1)
                .border(color: Color.yellow)
                .frame(width: 200, height: 200)
        }
	}
}
