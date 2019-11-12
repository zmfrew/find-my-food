import Foundation
//swiftlint:disable function_parameter_count

protocol BusinessSearchClientProtocol {
    func search(for business: String,
                latitude: Double,
                longitude: Double,
                radius: Int,
                prices: [Int],
                openNow: Bool,
                completion: @escaping ([Business]) -> Void)
    func image(at urlString: String, completion: @escaping (Data?) -> Void)
}

final class BusinessSearchClient: BusinessSearchClientProtocol {
    private let serviceClient: ServiceClientProtocol

	init(serviceClient: ServiceClientProtocol) {
        self.serviceClient = serviceClient
    }

    func search(for business: String,
                latitude: Double,
                longitude: Double,
                radius: Int,
                prices: [Int],
                openNow: Bool,
                completion: @escaping ([Business]) -> Void) {
        let prices = prices.map { String($0) }.joined(separator: ", ")

		let queryParams = [
            "term": business,
            "latitude": "\(latitude)",
            "longitude": "\(longitude)",
            "radius": "\(radius)",
            "price": prices,
            "openNow": "\(openNow)"
            // TODO: - Add location string for people wanting to manually input location & make lat long optional.
        ]

        let headers = ["Authorization": "Bearer \(Secret.apiKey)"]

        serviceClient.get(from: YelpRoutes.businessSearch, queryParams: queryParams, headers: headers) { result in
            switch result {
            case .success(let data):
                let businesses = self.decodeBusinesses(data)
                completion(businesses)

            case .failure(let error):
                print("Error occurred searching for businesses: \(error.localizedDescription)")
                completion([])
            }
        }
    }

    func image(at urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL string for downloading image")
            completion(nil)
            return
        }

        serviceClient.get(from: url, queryParams: [:], headers: [:]) { result in
            switch result {
            case .success(let data):
                completion(data)

            case .failure(let error):
                print("Error occurred downloading image: \(error.localizedDescription)")
                completion(nil)
            }
        }
    }

    private func decodeBusinesses(_ data: Data) -> [Business] {
        do {
            let responseDict = try JSONDecoder().decode(Response.self, from: data)
            return responseDict.businesses
        } catch {
            print("Error occurred decoding businesses: \(error.localizedDescription)")
            return []
        }
    }
}
