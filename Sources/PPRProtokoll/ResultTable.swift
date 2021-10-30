import SwiftPDFUI

struct ResultTable: View {
	
	let grayBackgroundColor = Color(red: 0.98, green: 0.98, blue: 0.98)
	
	var body: some View {
		VStack(spacing: 0) {
			
			HorizontalDivider()
			
			TableRow {
				Text("Testfall")
					.fontSize(13)
			} trailing: {
				Text("Status")
					.fontSize(13)
			}
			.background {
				grayBackgroundColor
			}

			HorizontalDivider()
			
			ForEach(0..<10) { _ in
				TableRow {
					Text("Hallo, Welt!").fontSize(10)
				} trailing: {
					SuccessTag()
				}
				
				HorizontalDivider()
			}
			
			TableRow {
				Text("Hallo, Welt!").fontSize(10)
			} trailing: {
				FailureTag()
			}
			
			HorizontalDivider()

			TableRow {
				Text("Hallo, Welt!").fontSize(10)
			} trailing: {
				ErrorTag()
			}
			.background {
				grayBackgroundColor
			}
			
			HorizontalDivider()
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
		}
	}
}

enum Result {
	case success
	case failure
	case error
}
