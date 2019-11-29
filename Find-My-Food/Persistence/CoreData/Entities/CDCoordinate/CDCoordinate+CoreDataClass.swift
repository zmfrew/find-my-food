import CoreData
import Foundation

final class CDCoordinate: NSManagedObject {
    @nonobjc func fetchRequest() -> NSFetchRequest<CDCoordinate> {
        NSFetchRequest<CDCoordinate>(entityName: "CDCoordinate")
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
