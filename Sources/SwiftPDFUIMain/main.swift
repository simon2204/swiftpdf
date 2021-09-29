import SwiftPDFUI

struct SwiftUITest: View {
	var body: some View {
		HStack {
			AnyView(Spacer())
			Spacer()
		}
	}
}

let page = SwiftUIPDFPage(rootView: SwiftUITest())

print(page)
