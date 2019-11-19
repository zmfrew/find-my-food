import Quick
import Nimble

@testable import Find_My_Food

final class ArrayExtensionSpec: QuickSpec {
    override func spec() {
        // MARK: - isNotEmpty -> Bool
        describe("isNotEmpty -> Bool") {
            context("given a non-empty array") {
                it("returns true") {
                    let numArr = [4, 0, 3, 1, 2]
                    let stringArr = ["one", "four", "two", "three", "zero"]
                    
                    expect(numArr.isNotEmpty).to(beTrue())
                    expect(stringArr.isNotEmpty).to(beTrue())
                }
            }
            
            context("given an empty array") {
                it("returns false") {
                    let numArr = [Int]()
                    let stringArr = [String]()
                    
                    expect(numArr.isNotEmpty).to(beFalse())
                    expect(stringArr.isNotEmpty).to(beFalse())
                }
            }
        }
        
        // MARK: - element(at index: Int) -> Element?
        describe("element(at index: Int) -> Element?") {
            context("given a [Int]") {
                it("returns the correct element for the given index") {
                    let numArr = [4, 0, 3, 1, 2]
                    
                    expect(numArr.element(at: 0)).to(equal(4))
                    expect(numArr.element(at: 1)).to(equal(0))
                    expect(numArr.element(at: 2)).to(equal(3))
                    expect(numArr.element(at: 3)).to(equal(1))
                    expect(numArr.element(at: 4)).to(equal(2))
                }
            }
            
            context("given a [String]") {
                it("returns the correct element for the given index") {
                    let stringArr = ["one", "four", "two", "three", "zero"]
                
                    expect(stringArr.element(at: 0)).to(equal("one"))
                    expect(stringArr.element(at: 1)).to(equal("four"))
                    expect(stringArr.element(at: 2)).to(equal("two"))
                    expect(stringArr.element(at: 3)).to(equal("three"))
                    expect(stringArr.element(at: 4)).to(equal("zero"))
                }
            }
        }
    }
}
