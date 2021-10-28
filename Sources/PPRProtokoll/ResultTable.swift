import SwiftPDFUI

struct ResultTable: View {
	
	var body: some View {
		
		VStack(spacing: 0) {
			HorizontalDivider()
			
			ForEach(0..<8) { _ in
				TableRow {
					Text("Hallo, \nWelt!")
						.padding(16)
					
				} trailing: {
					
					Text("Hallo, Welt!")
						.padding(16)
				}
			}
		}
	}
}

struct TableRow<Leading, Trailing>: View where Leading: View, Trailing: View {
	
	private var leadingItem: Leading
	
	private var trailingItem: Trailing
	
	init(@ViewBuilder leading: () -> Leading, @ViewBuilder trailing: () -> Trailing) {
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
			
			HorizontalDivider()
		}
	}
	
}

enum Result {
	case success
	case failure
	case error
}
