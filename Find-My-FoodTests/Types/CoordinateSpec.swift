import Quick
import Nimble

@testable import Find_My_Food

final class CoordinateSpec: QuickSpec {
    override func spec() {
        describe("init(from decoder:)") {
            it("decodes properly") {
                let path = Bundle(for: type(of: self)).path(forResource: "MockCoordinate", ofType: "json")!
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let coordinate = try! JSONDecoder().decode(Coordinate.self, from: data)
                
                expect(coordinate.latitude).to(equal(37.7776247966103))
                expect(coordinate.longitude).to(equal(-122.407012712007))
            }
            
            it("throws if decoding fails") {
                let path = Bundle(for: type(of: self)).path(forResource: "IncompleteMockCoordinate", ofType: "json")!
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let coordinate = try JSONDecoder().decode(Coordinate.self, from: data)
                    fail("Decoding coordinate should fail. Here is the coordinate: \(coordinate)")
                } catch {
                    expect(error.localizedDescription).to(equal("The data couldn’t be read because it is missing."))
                }
            }
        }
    }
}
