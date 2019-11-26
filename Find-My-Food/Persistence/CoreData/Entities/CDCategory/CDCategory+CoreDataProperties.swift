import CoreData
import Foundation

extension CDCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCategory> {
        return NSFetchRequest<CDCategory>(entityName: "CDCategory")
    }

    @NSManaged public var alias: String?
    @NSManaged public var title: String?
    @NSManaged public var business: NSSet?

}

// MARK: Generated accessors for business
extension CDCategory {

    @objc(addBusinessObject:)
    @NSManaged public func addToBusiness(_ value: CDBusiness)

    @objc(removeBusinessObject:)
    @NSManaged public func removeFromBusiness(_ value: CDBusiness)

    @objc(addBusiness:)
    @NSManaged public func addToBusiness(_ values: NSSet)

    @objc(removeBusiness:)
    @NSManaged public func removeFromBusiness(_ values: NSSet)

}
