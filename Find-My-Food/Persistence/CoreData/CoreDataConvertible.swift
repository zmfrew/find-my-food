import CoreData

protocol CoreDataConvertible {
    associatedtype ConvertableType
    
    func convert() -> ConvertableType
    func cdObject(_ object: ConvertableType) -> NSManagedObject
}
