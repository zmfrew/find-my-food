import Foundation

@testable import Find_My_Food

final class MockDecoder: DecoderProtocol {
    final class Stub {
        var decodeCallCount: Int { decodeCalledWith.count }
        var decodeCalledWith = [Data]()
        var decodeShouldReturn: Response = TestData.responseFromJson()
        var decodeShouldThrowWith: Error? = nil
    }
    
    var stub = Stub()
    
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        stub.decodeCalledWith.append(data)
        
        if let error = stub.decodeShouldThrowWith {
            throw error
        }
        
        return stub.decodeShouldReturn as! T
    }
}
