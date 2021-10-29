import SwiftPDFUI

struct ResultTable: View {
	var body: some View {
		VStack(spacing: 0) {
			HorizontalDivider()

			TableRow {
				Text("Hallo, Welt!")
					.padding(16)
			} trailing: {
				ErrorTag()
			}
		}
	}
}

struct TableRow<Leading, Trailing>: View where Leading: View, Trailing: View {
	
	private var leadingItem: Leading
	
	private var trailingItem: Trailing
	
	init(leading: () -> Leading, trailing: () -> Trailing) {
		self.leadingItem = leading()
		self.trailingItem = trailing()
	}
	
	var body: some View {
		
		VStack(spacing: 0) {
			
			HStack {
				
				leadingItem
				
				Spacer()
				
				trailingItem
			}
			.border(color: .red)
			
			HorizontalDivider()
		}
	}
	
}

enum Result {
	case success
	case failure
	case error
}
