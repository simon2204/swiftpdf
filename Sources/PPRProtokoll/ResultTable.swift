import SwiftPDFUI

struct ResultTable: View {
	var body: some View {
		VStack(spacing: 0) {
			
			HorizontalDivider()
			
			ForEach(0..<10) { _ in
				TableRow {
					Text("Hallo, Welt!")
				} trailing: {
					SuccessTag()
				}
			}
			
			TableRow {
				Text("Hallo, Welt!")
			} trailing: {
				FailureTag()
			}

			TableRow {
				Text("Hallo, Welt!")
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
					.padding(16)
				
				Spacer()
				
				trailingItem
					.frame(width: 120, alignment: .leading)
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
