import CoreData

extension NSManagedObjectContext {
    func performSave() -> Result<Void, Error> {
        do {
            try save()
            return .success(())
        } catch {
            return .failure(error)
        }
    }
}
