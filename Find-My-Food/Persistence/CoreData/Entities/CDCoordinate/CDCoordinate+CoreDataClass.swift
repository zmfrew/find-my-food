import CoreData
import Foundation

@objc(CDCoordinate)
final class CDCoordinate: NSManagedObject { }

extension CDCoordinate {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDCoordinate> {
        NSFetchRequest<CDCoordinate>(entityName: String(describing: self))
    }
}

extension CDCoordinate: CoreDataConvertible {
    @discardableResult convenience init(_ object: Coordinate, context: NSManagedObjectContext) {
        self.init(context: context)
        self.latitude = object.latitude
        self.longitude = object.longitude
    }

    func convert() -> Coordinate? {
        Coordinate(latitude: self.latitude, longitude: self.longitude)
    }
}
