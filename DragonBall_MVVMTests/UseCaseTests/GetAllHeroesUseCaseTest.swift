
@testable import DragonBall_MVVM
import XCTest

final class GetAllHeroesUseCaseTests: XCTestCase {
    
    func testSuccess() {
        guard let URLMock = Bundle(for: type(of: self)).url(forResource: "Heroes", withExtension: "json"),
              let data = try? Data(contentsOf: URLMock) else {
            return XCTFail("Mock can't be found")
        }
        let sut = GetAllHeroesUseCase()
        let expectation = self.expectation(description: "TestSuccess")
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute { result in
            guard case .success(let heroes) = result else {
                return
            }
            XCTAssertEqual(heroes.count, 16)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFailure() {
        let sut = GetAllHeroesUseCase()
        let expectation = self.expectation(description: "TestFailure")
        APISession.shared = APISessionMock { request in
            return .failure(APIErrorResponse.unknown(""))
        }
        sut.execute { result in
            guard case .failure = result else {
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}
    
