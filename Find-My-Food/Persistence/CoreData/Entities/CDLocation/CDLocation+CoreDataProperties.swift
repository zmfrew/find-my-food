import CoreData
import Foundation

extension CDLocation {
    @NSManaged public var address1: String
    @NSManaged public var address2: String?
    @NSManaged public var address3: String?
    @NSManaged public var city: String
    @NSManaged public var country: String
    @NSManaged public var displayAddress: [String]
    @NSManaged public var state: String
    @NSManaged public var zipCode: String
}
