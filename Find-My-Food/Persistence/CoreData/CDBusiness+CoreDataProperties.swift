import CoreData
import Foundation

extension CDBusiness {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDBusiness> {
        return NSFetchRequest<CDBusiness>(entityName: "CDBusiness")
    }

    @NSManaged public var alias: String?
    @NSManaged public var displayPhone: String?
    @NSManaged public var distance: Double
    @NSManaged public var id: String?
    @NSManaged public var image: Data?
    @NSManaged public var imageURLString: String?
    @NSManaged public var isClosed: Bool
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var priceLevel: String?
    @NSManaged public var rating: Double
    @NSManaged public var reviewCount: Int16
    @NSManaged public var transactions: [String]?
    @NSManaged public var urlString: String?
    @NSManaged public var category: NSSet?
    @NSManaged public var location: CDLocation?

}

// MARK: Generated accessors for category
extension CDBusiness {

    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: CDCategory)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: CDCategory)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: NSSet)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: NSSet)

}
