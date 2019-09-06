struct Response {
    let businesses: [Business]
    let total: Int
    let region: Region
    
    struct Region {
        let center: Coordinate
    }
}

extension Response: Decodable {
    enum CodingKeys: CodingKey {
        case businesses, total, region
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Response.CodingKeys.self)
        
        let businesses = try container.decode([Business].self, forKey: .businesses)
        let total = try container.decode(Int.self, forKey: .total)
        let region = try container.decode(Region.self, forKey: .region)
        
        self.init(businesses: businesses, total: total, region: region)
    }
}

extension Response.Region: Decodable { }
