import Foundation
//swiftlint:disable function_parameter_count

protocol BusinessSearchClientProtocol {
    func search(for business: String,
                latitude: Double?,
                location: String?,
                longitude: Double?,
                radius: Int,
                prices: [Int],
                openNow: Bool,
                completion: @escaping ([Business]) -> Void)
    func image(at urlString: String, completion: @escaping (Data?) -> Void)
}

final class BusinessSearchClient: BusinessSearchClientProtocol {
    private let decoder: DecoderProtocol
    private let serviceClient: ServiceClientProtocol

    init(decoder: DecoderProtocol, serviceClient: ServiceClientProtocol) {
        self.decoder = decoder
        self.serviceClient = serviceClient
    }

    func search(for business: String,
                latitude: Double?,
                location: String?,
                longitude: Double?,
                radius: Int,
                prices: [Int],
                openNow: Bool,
                completion: @escaping ([Business]) -> Void) {
        let prices = prices.map { String($0) }.joined(separator: ", ")

        let queryParams: [String: String]
        if let latitude = latitude, let longitude = longitude {
            queryParams = [
                "term": business,
                "latitude": "\(latitude)",
                "longitude": "\(longitude)",
                "radius": "\(radius)",
                "price": prices,
                "openNow": "\(openNow)"
            ]
        } else {
            queryParams = [
                "term": business,
                "location": location!,
                "radius": "\(radius)",
                "price": prices,
                "openNow": "\(openNow)"
            ]
        }

        let headers = ["Authorization": "Bearer \(Secret.apiKey)"]

        serviceClient.get(from: YelpRoutes.businessSearch, queryParams: queryParams, headers: headers) { result in
            switch result {
            case .success(let data):
                guard let response = try? self.decoder.decode(Response.self, from: data) else {
                    print("Error occured decoding response")
                    completion([])
                    return
                }

                completion(response.businesses)

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
}
