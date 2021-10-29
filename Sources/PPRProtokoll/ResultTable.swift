import SwiftPDFUI

struct ResultTable: View {
	
	var body: some View {
		
		VStack(spacing: 0) {
			HorizontalDivider()
			
			TableRow {
				Text("agagagaagga!")
					.padding(16)
				
			} trailing: {
				
				Text("dfdft!")
					.padding(16)
			}
			
			TableRow {
				Text("fadfafffafdaf!")
					.padding(16)
				
			} trailing: {
				
				Text("Hallo, Welt!Hallo, Welt!")
					.padding(16)
			}
			
			TableRow {
				Text("Hallo, Welt!")
					.padding(16)
				
			} trailing: {
				
				Text("Hallo, Hallo, Welt!Welt!")
					.padding(16)
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
