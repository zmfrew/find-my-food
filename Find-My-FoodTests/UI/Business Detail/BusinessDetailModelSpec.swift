import Quick
import Nimble

@testable import Find_My_Food

final class BusinessDetailModelSpec: QuickSpec {
    override func spec() {
        var testObject: BusinessDetailModel!
        var mockCoreData: MockCoreDataManager!
        var mockDelegate: MockBusinessDetailModelDelegate!
        
        beforeEach {
            mockCoreData = MockCoreDataManager()
            mockDelegate = MockBusinessDetailModelDelegate()
            testObject = BusinessDetailModel(business: TestData.createBusiness(), coreDataManager: mockCoreData, delegate: mockDelegate)
        }
        
        // MARK: - func favorite()
        describe("favorite()") {
            context("given coreDataManager returns successful result") {
                it("calls saveDidSucceed on the delegate") {
                    mockCoreData.stub.saveShouldCompleteWith = .success(())
                    
                    testObject.favorite()
                    
                    expect(mockDelegate.stub.saveDidSucceedCallCount).to(equal(1))
                    expect(mockDelegate.stub.saveDidFailCallCount).to(equal(0))
                }
            }
            
            context("given coreDataManger returns failure") {
                it("calls saveDidFail on the delegate") {
                    mockCoreData.stub.saveShouldCompleteWith = .failure(NSError(domain: "fail", code: -1, userInfo: nil))
                    
                    testObject.favorite()
                    
                    expect(mockDelegate.stub.saveDidSucceedCallCount).to(equal(0))
                    expect(mockDelegate.stub.saveDidFailCallCount).to(equal(1))
                }
            }
        }
    }
}
