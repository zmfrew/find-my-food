import UIKit

struct Business {
    let alias: String
    let categories: [Category]
    let coordinate: Coordinate
    let displayPhone: String
    let distance: Double
    let id: String
    var image: UIImage?
    let imageURLString: String
    let isClosed: Bool
    var isFavorite: Bool = false
    let location: Location
    let name: String
    let phone: String
    let priceLevel: String?
    let rating: Double
    let reviewCount: Int
    let transactions: [String]
    let urlString: String

    struct Category: Equatable {
        let alias: String
        let title: String
    }

    struct Location: Equatable {
        let address1: String
        let address2: String?
        let address3: String?
        let city: String
        let country: String
        let displayAddress: [String]
        let state: String
        let zipCode: String
    }
}

extension Business: Equatable {
    static func == (lhs: Business, rhs: Business) -> Bool {
        lhs.alias == rhs.alias &&
            lhs.categories == rhs.categories &&
            lhs.coordinate == rhs.coordinate &&
            lhs.displayPhone == rhs.displayPhone &&
            lhs.distance == rhs.distance &&
            lhs.id == rhs.id &&
            lhs.imageURLString == rhs.imageURLString &&
            lhs.isClosed == rhs.isClosed &&
            lhs.location == rhs.location &&
            lhs.name == rhs.name &&
            lhs.phone == rhs.phone &&
            lhs.priceLevel == rhs.priceLevel &&
            lhs.rating == rhs.rating &&
            lhs.reviewCount == rhs.reviewCount &&
            lhs.transactions == rhs.transactions &&
            lhs.urlString == rhs.urlString
    }
}

extension Business {
    func copy(alias: String? = nil,
              categories: [Category]? = nil,
              coordinates: Coordinate? = nil,
              displayPhone: String? = nil,
              distance: Double? = nil,
              id: String? = nil,
              image: UIImage? = nil,
              imageURLString: String? = nil,
              isClosed: Bool? = nil,
              isFavorite: Bool? = false,
              location: Location? = nil,
              name: String? = nil,
              phone: String? = nil,
              priceLevel: String? = nil,
              rating: Double? = nil,
              reviewCount: Int? = nil,
              transactions: [String]? = nil,
              urlString: String? = nil) -> Business {

        Business(alias: alias ?? self.alias,
                        categories: categories ?? self.categories,
                        coordinate: coordinates ?? self.coordinate,
                        displayPhone: displayPhone ?? self.displayPhone,
                        distance: distance ?? self.distance,
                        id: id ?? self.id,
                        image: image ?? self.image,
                        imageURLString: imageURLString ?? self.imageURLString,
                        isClosed: isClosed ?? self.isClosed,
                        isFavorite: isFavorite ?? self.isFavorite,
                        location: location ?? self.location,
                        name: name ?? self.name,
                        phone: phone ?? self.phone,
                        priceLevel: priceLevel ?? self.priceLevel,
                        rating: rating ?? self.rating,
                        reviewCount: reviewCount ?? self.reviewCount,
                        transactions: transactions ?? self.transactions,
                        urlString: urlString ?? self.urlString)
    }
}

extension Business: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, alias, name, image_url, is_closed, url, review_count, categories, rating, coordinates, transactions, price, location, phone, display_phone, distance //swiftlint:disable:this line_length
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Business.CodingKeys.self)

        let alias = try container.decode(String.self, forKey: .alias)
        let categories = try container.decode([Category].self, forKey: .categories)
        let coordinate = try container.decode(Coordinate.self, forKey: .coordinates)
        let displayPhone = try container.decode(String.self, forKey: .display_phone)
        let distance = try container.decode(Double.self, forKey: .distance)
        let id = try container.decode(String.self, forKey: .id)
        let imageURLString = try container.decode(String.self, forKey: .image_url)
        let isClosed = try container.decode(Bool.self, forKey: .is_closed)
        let location = try container.decode(Location.self, forKey: .location)
        let name = try container.decode(String.self, forKey: .name)
        let phone = try container.decode(String.self, forKey: .phone)
        let priceLevel = try container.decodeIfPresent(String.self, forKey: .price)
        let reviewCount = try container.decode(Int.self, forKey: .review_count)
        let rating = try container.decode(Double.self, forKey: .rating)
        let transactions = try container.decode([String].self, forKey: .transactions)
        let urlString = try container.decode(String.self, forKey: .url)

        self.init(alias: alias,
                  categories: categories,
                  coordinate: coordinate,
                  displayPhone: displayPhone,
                  distance: distance,
                  id: id,
                  image: nil,
                  imageURLString: imageURLString,
                  isClosed: isClosed,
                  location: location,
                  name: name,
                  phone: phone,
                  priceLevel: priceLevel,
                  rating: rating,
                  reviewCount: reviewCount,
                  transactions: transactions,
                  urlString: urlString)
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
                  country: country,
                  displayAddress: displayAddress,
                  state: state,
                  zipCode: zipCode)
    }
}
