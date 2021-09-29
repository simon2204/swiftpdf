import SwiftPDFUI

struct SwiftUITest: View {
	var body: some View {
		HStack {
			Spacer()
			Spacer()
		}
	}
}

let page = SwiftUIPDFPage(rootView: SwiftUITest())

print(page)
