extension Array {
	func max<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> Value? {
		let max = self.max { firstElement, secondElement in
			firstElement[keyPath: keyPath] < secondElement[keyPath: keyPath]
		}
		return max?[keyPath: keyPath]
	}
}
