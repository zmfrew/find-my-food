import Foundation

protocol BusinessSearchClientInterface {
    func search(for business: String, latitude: Double, longitude: Double, completion: @escaping ([Business]) -> Void)
    func image(at urlString: String, completion: @escaping (Data?) -> Void)
}

final class BusinessSearchClient: BusinessSearchClientInterface {
    private let serviceClient: ServiceClientInterface
	private let networkIndicator: NetworkInterface
    
	init(serviceClient: ServiceClientInterface, networkIndicator: NetworkInterface) {
        self.serviceClient = serviceClient
		self.networkIndicator = networkIndicator
    }
    
    func search(for business: String, latitude: Double, longitude: Double, completion: @escaping ([Business]) -> Void) {
		let queryParams = [
            "term": business,
            "latitude": "\(latitude)",
            "longitude": "\(longitude)",
            "radius": "40000" // This is the widest range given in meters, which is approximately 25 miles.
        ]
        
        let headers = ["Authorization": "Bearer \(Secret.apiKey)"]
        
        serviceClient.get(from: YelpRoutes.businessSearch, queryParams: queryParams, headers: headers) { result in
			defer { self.networkIndicator.activityDidEnd() }
			
			self.networkIndicator.activityDidBegin()
			
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
