import CoreData
import Foundation

extension CDCoordinate {
    @NSManaged var business: CDBusiness?
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
}
