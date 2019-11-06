import Foundation

enum NetworkError: Error, Equatable {
    case invalidUrl, invalidQueryParams, apiError, invalidApiResponse
}

protocol ServiceClientProtocol {
    func get(from url: URL, queryParams: [String: String], headers: [String: String], completion: @escaping (Result<Data, Error>) -> Void)
}

final class BaseServiceClient: ServiceClientProtocol {
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func get(from url: URL, queryParams: [String: String], headers: [String: String], completion: @escaping (Result<Data, Error>) -> Void) {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let queryItems = queryParams.enumerated().compactMap { URLQueryItem(name: $0.element.key, value: $0.element.value) }
        components.queryItems = queryItems
        
        guard let urlFromComponents = components.url else {
            completion(.failure(NetworkError.invalidQueryParams))
            return
        }
        
        var urlRequest = URLRequest(url: urlFromComponents)
        headers.forEach { (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        urlSession.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print("Error occurred with get request: \(error.localizedDescription).")
                completion(.failure(NetworkError.apiError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidApiResponse))
                return
            }
            
            completion(.success(data))
        }
    }
}
