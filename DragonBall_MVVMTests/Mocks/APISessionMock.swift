@testable import DragonBall_MVVM
import XCTest

final class APISessionMock: APISessionContract {
    let mockResponse: ((any APIRequest) -> Result<Data, any Error>)
    
    init(mockResponse: @escaping ((any APIRequest) -> Result<Data, any Error>)) {
        self.mockResponse = mockResponse
    }
    
    func request<Request>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) where Request : APIRequest {
        completion(mockResponse(apiRequest))
    }
}

