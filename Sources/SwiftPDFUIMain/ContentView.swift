import SwiftPDFUI

struct ContentView: View {
	
	let lorem = """
	Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
	"""
	
	var body: some View {
		HStack {
			Text(lorem)
				.frame(width: 60)
				.border(color: .green)
			
			Text(lorem)
				.frame(width: 80)
				.border(color: .green)
			
			Text(lorem)
				.frame(width: 100)
				.border(color: .green)
		}
	}
}


