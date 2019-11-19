extension Array {
    var isNotEmpty: Bool {
        !self.isEmpty
    }

    func element(at index: Int) -> Element? {
        guard index >= 0 && index < self.count else { return nil }
        return self[index]
    }
}
