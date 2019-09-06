import Foundation

protocol BusinessSearchClientInterface {
    func search(for business: String, latitude: Double, longitude: Double, completion: @escaping ([Business]) -> Void)
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
                print("Error occurred in BaseServiceClient: \(error.localizedDescription)")
                completion([])
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
