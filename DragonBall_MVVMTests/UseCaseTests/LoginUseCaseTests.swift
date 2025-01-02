
@testable import DragonBall_MVVM
import XCTest


final class DummySessionDataSource: SessionDataSourceContract {
    var session: Data?
    
    func storeSession(_ session: Data) {
        self.session = session
    }
    
    func getSession() -> Data? {
        nil
    }
    
    
}

final class LoginUseCaseTests: XCTestCase {
    
    func testSuccessStoresToken() {
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(dataSource: dataSource)
        
        let expectation = self.expectation(description: "Login")
        let data = Data("hello-world".utf8)
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute(credentials: Credentials(username: "a@b.es", password: "122345")) {result in
            guard case .success = result else {
                return
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(dataSource.session, data)
    }
    
      func testFailureStoresToken() {
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(dataSource: dataSource)
        
        let expectation = self.expectation(description: "TestFailure")
        
          APISession.shared = APISessionMock { _ in .failure(APIErrorResponse.network("login-fail")) }
          
        sut.execute(credentials: Credentials(username: "a@b.es", password: "122345")) {result in
            guard case .failure = result else {
                return
            }
           
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertNil(dataSource.session)
    }
}
