import Foundation

@testable import Find_My_Food

enum TestData {
    static func createBusiness() -> Business {
        return Business(id: "test id", alias: "test alias", name: "test name", imageUrlString: "test imageUrlString", isClosed: false, urlString: "test urlString", reviewCount: 0, categories: [], rating: 1.0, coordinates: Coordinate(latitude: 1.0, longitude: 1.0), transactions: [], priceLevel: nil, location: Business.Location(address1: "test address1", address2: "test address2", address3: "test address3", city: "test city", zipCode: "test zipCode", country: "test country", state: "test state", displayAddress: []), phone: "test phone", displayPhone: "test displayPhone", distance: 1.0)
    }
    
    static func businessData() -> Data {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "MockBusinesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return data
    }
    
    static func businessesFromJson() -> [Business] {
        let data = businessData()
        let businesses = try! JSONDecoder().decode([Business].self, from: data)
        return businesses
    }
}
