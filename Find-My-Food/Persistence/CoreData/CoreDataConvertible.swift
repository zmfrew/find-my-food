import CoreData

protocol CoreDataConvertible {
    associatedtype ConvertibleType

    func convert() -> ConvertibleType
    @discardableResult init(_ object: ConvertibleType, context: NSManagedObjectContext)
}
