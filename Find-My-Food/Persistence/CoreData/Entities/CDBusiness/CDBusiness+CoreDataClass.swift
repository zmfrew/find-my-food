import CoreData
import UIKit

@objc(CDBusiness)
final class CDBusiness: NSManagedObject { }

extension CDBusiness {
    @nonobjc class func fetchRequest() -> NSFetchRequest<CDBusiness> {
        NSFetchRequest<CDBusiness>(entityName: String(describing: self))
    }
}

extension CDBusiness: CoreDataConvertible {
    @discardableResult convenience init(_ object: Business, context: NSManagedObjectContext) {
        self.init(context: context)
        self.alias = object.alias
        self.categories = Set(object.categories.map { CDCategory($0, context: context) })
        self.coordinate = CDCoordinate(object.coordinate, context: context)
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
        guard let coordinate = self.coordinate.convert(),
            let imageData = self.image,
            let location = self.location.convert()
        else { return nil }

        let categories = self.categories.compactMap { $0.convert() }

        return Business(alias: self.alias,
                        categories: categories,
                        coordinate: coordinate,
                        displayPhone: self.displayPhone,
                        distance: self.distance,
                        id: self.id,
                        image: UIImage(data: imageData),
                        imageURLString: self.imageURLString,
                        isClosed: self.isClosed,
                        location: location,
                        name: self.name,
                        phone: self.phone,
                        priceLevel: self.priceLevel,
                        rating: self.rating,
                        reviewCount: Int(self.reviewCount),
                        transactions: self.transactions,
                        urlString: self.urlString)
    }
}
