import Quick
import Nimble

@testable import Find_My_Food

final class StringExtensionSpec: QuickSpec {
    override func spec() {
        // MARK: - var phoneURL: URL?
        describe("phoneURL: URL?") {
            context("given a valid phone number") {
                it("returns a URL") {
                    let expectedString1 = "+13141234567"
                    let expectedURL1 = URL(string: "tel://\(expectedString1)")
                    let expectedString2 = "12345789"
                    let expectedURL2 = URL(string: "tel://\(expectedString2)")
                    let expectedString3 = "1234578910"
                    let expectedURL3 = URL(string: "tel://\(expectedString3)")
                    
                    expect(expectedString1.phoneURL).to(beAKindOf(URL.self))
                    expect(expectedString1.phoneURL).to(equal(expectedURL1))
                    
                    expect(expectedString2.phoneURL).to(beAKindOf(URL.self))
                    expect(expectedString2.phoneURL).to(equal(expectedURL2))
                    
                    expect(expectedString3.phoneURL).to(beAKindOf(URL.self))
                    expect(expectedString3.phoneURL).to(equal(expectedURL3))
                }
            }
            
            context("given an invalid phone number") {
                it("returns nil") {
                    let expectedString1 = "1 (314) 123-4567"
                    let expectedString2 = "1 2 3 4 5 7 8 9"
                    let expectedString3 = " "
                    let expectedString4 = "this wont work"
                    
                    expect(expectedString1.phoneURL).to(beNil())
                    expect(expectedString2.phoneURL).to(beNil())
                    expect(expectedString3.phoneURL).to(beNil())
                    expect(expectedString4.phoneURL).to(beNil())
                }
            }
        }
        
        // MARK: - var priceToInt: Int?
        describe("priceToInt: Int?") {
            context("given $, $$, $$$, or $$$$") {
                it("returns the number of $'s") {
                    expect("$".priceToInt).to(equal(1))
                    expect("$$".priceToInt).to(equal(2))
                    expect("$$$".priceToInt).to(equal(3))
                    expect("$$$$".priceToInt).to(equal(4))
                }
            }
            
            context("anything except $, $$, $$$, $$$$") {
                it("returns nil") {
                    expect("$#".priceToInt).to(beNil())
                    expect("-$".priceToInt).to(beNil())
                    expect("this".priceToInt).to(beNil())
                    expect("1".priceToInt).to(beNil())
                }
            }
        }
    }
}
