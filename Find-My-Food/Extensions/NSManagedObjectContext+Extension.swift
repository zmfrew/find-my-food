import CoreData

extension NSManagedObjectContext {
    @discardableResult
    func performSave() -> Result<Void, Error> {
        do {
            try save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
