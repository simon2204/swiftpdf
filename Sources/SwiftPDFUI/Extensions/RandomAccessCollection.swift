extension RandomAccessCollection {

	/// return a sorted collection
	/// this use a stable sort algorithm
	///
	/// - Parameter areInIncreasingOrder: return nil when two element are equal
	/// - Returns: the sorted collection
	public func stableSorted(by areInIncreasingOrder: (Element, Element) throws -> Bool) rethrows -> [Element] {
		let sorted = try enumerated().sorted { (one, another) -> Bool in
			if try areInIncreasingOrder(one.element, another.element) {
				return true
			} else {
				return one.offset < another.offset
			}
		}
		return sorted.map { $0.element }
	}
}
