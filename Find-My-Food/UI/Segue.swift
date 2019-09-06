enum MapSearchSegue: String {
    case showBusinessSearch
    
    var name: String { return self.rawValue }
}

enum BusinessSearchSegue: String {
    case showBusinesses
    
    var name: String { return self.rawValue }
}
