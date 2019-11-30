import CoreData
import Foundation

final class CDCategory: NSManagedObject { }

extension CDCategory {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDCategory> {
        NSFetchRequest<CDCategory>(entityName: String(describing: self))
      }
}

extension CDCategory: CoreDataConvertible {
    @discardableResult convenience init(_ object: Business.Category, context: NSManagedObjectContext) {
        self.init(context: context)
        self.alias = object.alias
        self.title = object.title
    }

    func convert() -> Business.Category? {
        Business.Category(alias: self.alias, title: self.title)
    }
}
