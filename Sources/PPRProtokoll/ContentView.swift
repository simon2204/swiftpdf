import SwiftPDFUI

struct ContentView: View {
	
	private let leadingPadding = 30.0
	
	var body: some View {
		VStack(alignment: .leading, spacing: 30) {
			
			Title(primary: "Auswertungsprotokoll", secondary: "PPR Testbench")
				.padding(.leading, leadingPadding)

			HorizontalDivider(title: "Übersicht")

			Overview(
				name: "Alexander Schmitz",
				creationDate: "October 28, 2021 um 10:45 Uhr",
				taskName: "Matrix (Blatt 2)",
				result: "10/10 (100%)"
			)
				.padding(.leading, leadingPadding)

			HorizontalDivider(title: "Auswertung")

			ResultTable()

			Spacer(minLength: 0)
		}
		.padding(.top, 30)
	}
}
