import Foundation

protocol DecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable
}

extension JSONDecoder: DecoderProtocol { }

struct DecoderWrapper: DecoderProtocol {

    private let decoder: DecoderProtocol

    init(decoder: DecoderProtocol) {
        self.decoder = decoder
    }

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T: Decodable {
        do {
            let returnType = try decoder.decode(T.self, from: data)
            return returnType
        } catch {
            throw error
        }
    }
}
