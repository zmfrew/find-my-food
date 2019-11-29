import Foundation

@testable import Find_My_Food

enum TestData {
    static func createBusiness() -> Business {
        Business(alias: "test alias",
                 categories: [],
                 coordinate: Coordinate(latitude: 1.0, longitude: 1.0),
                 displayPhone: "test displayPhone",
                 distance: 1.0,
                 id: "test id",
                 image: nil,
                 imageURLString: "test imageURLString",
                 isClosed: false,
                 location: Business.Location(address1: "test address1",
                                             address2: "test address2",
                                             address3: "test address3",
                                             city: "test city",
                                             country: "test country",
                                             displayAddress: [],
                                             state: "test state", zipCode: "test zipCode"),
                 name: "test name",
                 phone: "test phone",
                 priceLevel: "test priceLevel",
                 rating: 1.0,
                 reviewCount: 0,
                 transactions: [],
                 urlString: "test urlString")
    }
    
    static func businessData() -> Data {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "businesses", ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    static func businessesFromJson() -> [Business] {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "businesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        let response = try! JSONDecoder().decode(Response.self, from: data)
        return response.businesses
    }
    
    static func businessesFromMockBusinessesFile() -> [Business] {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "MockBusinesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONDecoder().decode([Business].self, from: data)
    }
    
    static func responseFromJson() -> Response {
        let path = Bundle(identifier: "com.zachfrew.Find-My-FoodTests")!.path(forResource: "businesses", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        return try! JSONDecoder().decode(Response.self, from: data)
    }
}
