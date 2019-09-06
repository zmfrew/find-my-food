protocol BusinessModelInterface {
	func business(for row: Int) -> Business?
	var businessCount: Int { get }
}

final class BusinessesModel: BusinessModelInterface {
	private let businesses: [Business]
	var businessCount: Int { return businesses.count }
	
	init(businesses: [Business]) {
		self.businesses = businesses
	}
	
	func business(for row: Int) -> Business? {
		return businesses.element(at: row)
	}
}
