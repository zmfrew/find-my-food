import CoreData
import Foundation

final class CDBusiness: NSManagedObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDBusiness> {
        NSFetchRequest<CDBusiness>(entityName: "CDBusiness")
    }
}

extension CDBusiness: CoreDataConvertible {
    @discardableResult convenience init(_ object: Business, context: NSManagedObjectContext) {
        self.init(context: context)
        self.alias = object.alias
        self.categories = Set(object.categories.map { CDCategory($0, context: context) })
        self.displayPhone = object.displayPhone
        self.distance = object.distance
        self.id = object.id
        self.image = object.image?.pngData()
        self.imageURLString = object.imageURLString
        self.isClosed = object.isClosed
        self.location = CDLocation(object.location, context: context)
        self.name = object.name
        self.phone = object.phone
        self.priceLevel = object.priceLevel
        self.rating = object.rating
        self.reviewCount = Int16(object.reviewCount)
        self.transactions = object.transactions
        self.urlString = object.urlString
    }

    func convert() -> Business? {

        return nil
    }
}
