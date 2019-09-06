extension Array {
	func element(at index: Int) -> Element? {
		guard index >= 0 && index < self.count else { return nil }
		return self[index]
	}
	
	func isNotEmpty() -> Bool {
		return !self.isEmpty
	}
}
