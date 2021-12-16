import Foundation

extension String {
	var isWhitespace: Bool {
		self.trimmingCharacters(in: .whitespaces).isEmpty
	}
}

extension String {
	func components(separatedBy seperator: CharacterSet) -> [String] {
		let scalars = self.unicodeScalars

		var tokens = [String]()

		var currentIndex = scalars.startIndex

		processSeperators()

		while true {

			// Find index of the first occuring seperator after `currentIndex`.
			let seperatorStartIndex = scalars[currentIndex...].firstIndex(where: { seperator.contains($0) })

			// Nothing more to seperate.
			guard let seperatorStartIndex = seperatorStartIndex else {

				// Prevents the empty `String` to be appended.
				if currentIndex < scalars.endIndex {
					// Append last word.
					tokens.append(String(scalars[currentIndex...]))
				}
				
				return tokens
			}

			// Sequence of characters without seperators.
			let token = String(scalars[currentIndex..<seperatorStartIndex])
			
			tokens.append(token)

			currentIndex = seperatorStartIndex

			processSeperators()
		}
		
		/// Appends all succeeding seperators to the token list and increases the `currentIndex`accordingly.
		func processSeperators() {
			while currentIndex < scalars.endIndex && seperator.contains(scalars[currentIndex]) {
				tokens.append(String(scalars[currentIndex]))
				currentIndex = scalars.index(after: currentIndex)
			}
		}
	}
}

func wordWrap(text: String, maxLineLength: Double, characterWidth: (Character) -> Double) -> [String] {
	
	var lines: [String] = []
	
	let components = text.components(separatedBy: .whitespacesAndNewlines)
	
	var currentLineLength: Double = 0
	var currentLine = ""
	var isExplicitNewline = true
	
	var currentLineIsEmpty: Bool {
		currentLineLength == 0
	}
	
	var wordIterator = components.makeIterator()

	while let word = wordIterator.next() {
		
		if word == "\n" {
			
			appendNewLine()
			isExplicitNewline = true
			
		} else {
			
			if newWordExceedsMaxWidth(word) && !currentLineIsEmpty {
				appendNewLine()
				isExplicitNewline = false
			}
			
			if !word.isWhitespace || !currentLineIsEmpty || isExplicitNewline {
				append(word: word)
			}
		}
	}
	
	if !currentLine.isEmpty {
		lines.append(currentLine)
	}
	
	func newWordExceedsMaxWidth(_ word: String) -> Bool {
		let wordWidth = word.reduce(0, { $0 + characterWidth($1) })
		return currentLineLength + wordWidth > maxLineLength
	}
	
	/// Appends a word to the current line or splits it up into multiple lines,
	/// when it does not fit into a single line.
	func append(word: String) {
		for char in word {
			if currentLineLength + characterWidth(char) > maxLineLength {
				appendNewLine()
				isExplicitNewline = false
			}
			currentLine.append(char)
			currentLineLength += characterWidth(char)
		}
	}
	
	func appendNewLine() {
		lines.append(currentLine)
		currentLineLength = 0
		currentLine = ""
	}
	
	return lines
}
