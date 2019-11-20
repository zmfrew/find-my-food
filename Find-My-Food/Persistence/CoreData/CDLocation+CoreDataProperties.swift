import CoreData
import Foundation

extension CDLocation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLocation> {
        return NSFetchRequest<CDLocation>(entityName: "CDLocation")
    }

    @NSManaged public var address1: String?
    @NSManaged public var address2: String?
    @NSManaged public var address3: String?
    @NSManaged public var city: String?
    @NSManaged public var country: String?
    @NSManaged public var displayAddress: [String]?
    @NSManaged public var state: String?
    @NSManaged public var zipCode: String?
    @NSManaged public var business: NSSet?

}

// MARK: Generated accessors for business
extension CDLocation {

    @objc(addBusinessObject:)
    @NSManaged public func addToBusiness(_ value: CDBusiness)

    @objc(removeBusinessObject:)
    @NSManaged public func removeFromBusiness(_ value: CDBusiness)

    @objc(addBusiness:)
    @NSManaged public func addToBusiness(_ values: NSSet)

    @objc(removeBusiness:)
    @NSManaged public func removeFromBusiness(_ values: NSSet)

}
