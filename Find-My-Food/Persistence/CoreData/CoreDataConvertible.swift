import CoreData

protocol CoreDataConvertible {
    associatedtype ConvertableType

    func convert() -> ConvertableType
    @discardableResult init(_ object: ConvertableType)
}
