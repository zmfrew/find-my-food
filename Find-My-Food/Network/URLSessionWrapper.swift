import Foundation

protocol URLSessionWrapperInterface {
    func dataTask(with: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

class URLSessionWrapper: URLSessionWrapperInterface {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: request, completionHandler: completionHandler).resume() // maybe remove resume from here
    }
}
