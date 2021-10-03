extension Optional where Wrapped: Numeric {
	static func + (lhs: Optional<Wrapped>, rhs: Optional<Wrapped>) -> Optional<Wrapped> {
		switch (lhs, rhs) {
		case let (.some(num1), .some(num2)):
			return num1 + num2
		case let (.none, .some(num)):
			return num
		case let (.some(num), .none):
			return num
		case (.none, .none):
			return 0
		}
	}

	static func += (lhs: inout Optional<Wrapped>, rhs: Optional<Wrapped>) {
		lhs = lhs + rhs
	}
}
