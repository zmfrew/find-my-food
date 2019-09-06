import Quick
import Nimble

@testable import Find_My_Food

final class ResponseSpec: QuickSpec {
    override func spec() {
        describe("init(from decoder:)") {
            it("decodes properly") {
                let path = Bundle(for: type(of: self)).path(forResource: "MockResponse", ofType: "json")!
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let response = try! JSONDecoder().decode(Response
                    .self, from: data)
                
                expect(response.businesses.count).to(equal(2))
                expect(response.total).to(equal(2))
                expect(response.region.center.latitude).to(equal(37.786882))
                expect(response.region.center.longitude).to(equal(-122.399972))
            }
            
            it("throws if decoding fails") {
                let path = Bundle(for: type(of: self)).path(forResource: "IncompleteMockResponse", ofType: "json")!
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    fail("Decoding response should fail. Here is the response: \(response)")
                } catch {
                    expect(error.localizedDescription).to(equal("The data couldn’t be read because it is missing."))
                }
            }
        }
    }
}
