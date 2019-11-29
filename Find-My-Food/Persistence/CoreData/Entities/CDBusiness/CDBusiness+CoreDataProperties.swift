import CoreData
import Foundation

extension CDBusiness {
    @NSManaged var alias: String
    @NSManaged var categories: Set<CDCategory>
    @NSManaged var displayPhone: String
    @NSManaged var distance: Double
    @NSManaged var id: String
    @NSManaged var image: Data?
    @NSManaged var imageURLString: String
    @NSManaged var isClosed: Bool
    @NSManaged var location: CDLocation
    @NSManaged var name: String
    @NSManaged var phone: String
    @NSManaged var priceLevel: String?
    @NSManaged var rating: Double
    @NSManaged var reviewCount: Int16
    @NSManaged var transactions: [String]
    @NSManaged var urlString: String
}

// MARK: Generated accessors for category
extension CDBusiness {
    @objc(addCategoryObject:)
    @NSManaged public func addToCategory(_ value: CDCategory)

    @objc(removeCategoryObject:)
    @NSManaged public func removeFromCategory(_ value: CDCategory)

    @objc(addCategory:)
    @NSManaged public func addToCategory(_ values: Set<CDCategory>)

    @objc(removeCategory:)
    @NSManaged public func removeFromCategory(_ values: Set<CDCategory>)
}
