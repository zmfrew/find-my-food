import CoreData
import Foundation

final class CDLocation: NSManagedObject {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDLocation> {
        NSFetchRequest<CDLocation>(entityName: String(describing: self))
    }
}

extension CDLocation: CoreDataConvertible {
    @discardableResult convenience init(_ object: Business.Location, context: NSManagedObjectContext) {
        self.init(context: context)
        address1 = object.address1
        address2 = object.address2
        address3 = object.address3
        city = object.city
        country = object.country
        displayAddress = object.displayAddress
        state = object.state
        zipCode = object.zipCode
    }

    func convert() -> Business.Location? {
        Business.Location(address1: self.address1,
                          address2: self.address2,
                          address3: self.address3,
                          city: self.city,
                          country: self.country,
                          displayAddress: self.displayAddress,
                          state: self.state,
                          zipCode: self.zipCode)
    }
}
