import UIKit

struct Business {
    let id: String
    let alias: String
    let name: String
    let imageUrlString: String
    var image: UIImage?
    let isClosed: Bool
    let urlString: String
    let reviewCount: Int
    let categories: [Category]
    let rating: Double
    let coordinates: Coordinate
    let transactions: [String]
    let priceLevel: String?
    let location: Location
    let phone: String
    let displayPhone: String
    let distance: Double

    struct Category: Equatable {
        let alias: String
        let title: String
    }

    struct Location: Equatable {
        let address1: String
        let address2: String?
        let address3: String?
        let city: String
        let zipCode: String
        let country: String
        let state: String
        let displayAddress: [String]
    }
}

extension Business: Equatable {
    static func == (lhs: Business, rhs: Business) -> Bool {
        return lhs.id == rhs.id &&
            lhs.alias == rhs.alias &&
            lhs.alias == rhs.alias &&
            lhs.name == rhs.name &&
            lhs.imageUrlString == rhs.imageUrlString &&
            lhs.isClosed == rhs.isClosed &&
            lhs.urlString == rhs.urlString &&
            lhs.reviewCount == rhs.reviewCount &&
            lhs.categories == rhs.categories &&
            lhs.rating == rhs.rating &&
            lhs.coordinates == rhs.coordinates &&
            lhs.transactions == rhs.transactions &&
            lhs.priceLevel == rhs.priceLevel &&
            lhs.location == rhs.location &&
            lhs.phone == rhs.phone &&
            lhs.displayPhone == rhs.displayPhone &&
            lhs.distance == rhs.distance
    }
}

extension Business {
    func copy(id: String? = nil,
              alias: String? = nil,
              name: String? = nil,
              imageUrlString: String? = nil,
              image: UIImage? = nil,
              isClosed: Bool? = nil,
              urlString: String? = nil,
              reviewCount: Int? = nil,
              categories: [Category]? = nil,
              rating: Double? = nil,
              coordinates: Coordinate? = nil,
              transactions: [String]? = nil,
              priceLevel: String? = nil,
              location: Location? = nil,
              phone: String? = nil,
              displayPhone: String? = nil,
              distance: Double? = nil) -> Business {

        return Business(id: id ?? self.id,
                        alias: alias ?? self.alias,
                        name: name ?? self.name,
                        imageUrlString: imageUrlString ?? self.imageUrlString,
                        image: image ?? self.image,
                        isClosed: isClosed ?? self.isClosed,
                        urlString: urlString ?? self.urlString,
                        reviewCount: reviewCount ?? self.reviewCount,
                        categories: categories ?? self.categories,
                        rating: rating ?? self.rating,
                        coordinates: coordinates ?? self.coordinates,
                        transactions: transactions ?? self.transactions,
                        priceLevel: priceLevel ?? self.priceLevel,
                        location: location ?? self.location,
                        phone: phone ?? self.phone,
                        displayPhone: displayPhone ?? self.displayPhone,
                        distance: distance ?? self.distance)
    }
}

extension Business: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, alias, name, image_url, is_closed, url, review_count, categories, rating, coordinates, transactions, price, location, phone, display_phone, distance //swiftlint:disable:this line_length
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Business.CodingKeys.self)

        let id = try container.decode(String.self, forKey: .id)
        let alias = try container.decode(String.self, forKey: .alias)
        let name = try container.decode(String.self, forKey: .name)
        let imageUrlString = try container.decode(String.self, forKey: .image_url)
        let isClosed = try container.decode(Bool.self, forKey: .is_closed)
        let urlString = try container.decode(String.self, forKey: .url)
        let reviewCount = try container.decode(Int.self, forKey: .review_count)
        let categories = try container.decode([Category].self, forKey: .categories)
        let rating = try container.decode(Double.self, forKey: .rating)
        let coordinates = try container.decode(Coordinate.self, forKey: .coordinates)
        let transactions = try container.decode([String].self, forKey: .transactions)
        let priceLevel = try container.decodeIfPresent(String.self, forKey: .price)
        let location = try container.decode(Location.self, forKey: .location)
        let phone = try container.decode(String.self, forKey: .phone)
        let displayPhone = try container.decode(String.self, forKey: .display_phone)
        let distance = try container.decode(Double.self, forKey: .distance)

        self.init(id: id,
                  alias: alias,
                  name: name,
                  imageUrlString: imageUrlString,
                  isClosed: isClosed,
                  urlString: urlString,
                  reviewCount: reviewCount,
                  categories: categories,
                  rating: rating,
                  coordinates: coordinates,
                  transactions: transactions,
                  priceLevel: priceLevel,
                  location: location,
                  phone: phone,
                  displayPhone: displayPhone,
                  distance: distance)
    }
}

extension Business.Category: Decodable { }

extension Business.Location: Decodable {
    enum CodingKeys: CodingKey {
        case address1, address2, address3, city, zip_code, country, state, display_address
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Business.Location.CodingKeys.self)

        let address1 = try container.decode(String.self, forKey: .address1)
        let address2 = try container.decodeIfPresent(String.self, forKey: .address2)
        let address3 = try container.decodeIfPresent(String.self, forKey: .address3)
        let city = try container.decode(String.self, forKey: .city)
        let zipCode = try container.decode(String.self, forKey: .zip_code)
        let country = try container.decode(String.self, forKey: .country)
        let state = try container.decode(String.self, forKey: .state)
        let displayAddress = try container.decode([String].self, forKey: .display_address)

        self.init(address1: address1,
                  address2: address2,
                  address3: address3,
                  city: city,
                  zipCode: zipCode,
                  country: country,
                  state: state,
                  displayAddress: displayAddress)
    }
}
