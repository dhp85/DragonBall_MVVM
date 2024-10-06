
@testable import DragonBall_MVVM
import XCTest

private final class SuccessGetHeroesUseCaseMock: GetAllHeroesUseCaseContract {
    func execute(completion: @escaping (Result<[DragonBall_MVVM.Hero], any Error>) -> Void) {
        completion(.success([Hero(id: "12345", name: "Goku", description: "", photo: "", favorite: false)]))
    }
}

private final class FailureGetHeroesUseCaseMock: GetAllHeroesUseCaseContract {
    func execute(completion: @escaping (Result<[DragonBall_MVVM.Hero], any Error>) -> Void) {
        completion(.failure(APIErrorResponse.unknown("")))
    }
}


final class HeroesListViewModelTests: XCTestCase {
    
    func testSuccessGetHeroes() {
        let successExpectation = expectation(description: "Success")
        let loadingExpactation = expectation(description: "Loading")
        let useCaseMock = SuccessGetHeroesUseCaseMock()
        let sut = HeroesListViewModel(useCase: useCaseMock)
        
        sut.onStateChange.bind { state in
            if case .loading = state {
                loadingExpactation.fulfill()
            } else if case .success = state {
                successExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.heroes.count, 1)
        
    }
    
    func testFailureGetHeroes() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpactation = expectation(description: "Loading")
        let useCaseMock = FailureGetHeroesUseCaseMock()
        let sut = HeroesListViewModel(useCase: useCaseMock)
        
        sut.onStateChange.bind { state in
            if case .loading = state {
                loadingExpactation.fulfill()
            } else if case .error = state {
                errorExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.heroes.count, 0)
        
    }
}
