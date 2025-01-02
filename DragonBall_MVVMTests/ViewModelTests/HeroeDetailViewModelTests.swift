@testable import DragonBall_MVVM
import XCTest

private final class MockSuccessGetHeroeDetailUseCase: GetHeroeDetailUseCaseContract {
    func execute(heroe: String, completion: @escaping (Result<DragonBall_MVVM.Hero?, Error>) -> Void) {
        completion(.success(Hero(id: "1234", name: "Goku", description: "", photo: "", favorite: true)))
    }
}

private final class MockFailureGetHeroeDetailUseCase: GetHeroeDetailUseCaseContract {
    func execute(heroe: String, completion: @escaping (Result<DragonBall_MVVM.Hero?, Error>) -> Void) {
        completion(.failure(APIErrorResponse.unknown("")))
    }
}

final class HeroeDetailViewModelTests: XCTestCase {
    
    func testSuccessHeroe() {
        let heroName = "Goku"
        let useCaseMock = MockSuccessGetHeroeDetailUseCase()
        let sut = HeroeDetailViewModel(heroName: heroName, useCase: useCaseMock)
        
        let successExpectation = expectation(description: "State Changed to Success")
        let loadingExpectation = expectation(description: "Loading")
        
        sut.onStateChanged.bind { state in
            if case .loading = state {
                loadingExpectation.fulfill()
            } else if case .success = state {
                successExpectation.fulfill()
            }
        }
        
        sut.load()
        
        waitForExpectations(timeout: 6.0)
        XCTAssertEqual(sut.hero?.name, heroName)
            
    }

    func testFailureHeroe() {
        let heroName = "InvalidHero"
        let useCaseMock = MockFailureGetHeroeDetailUseCase()
        let sut = HeroeDetailViewModel(heroName: heroName, useCase: useCaseMock)

        let expectation = self.expectation(description: "State Changed to Error")
        
        sut.onStateChanged.bind { state in
            if case .error = state {
                expectation.fulfill()
            }
        }
        
        sut.load()
        
        waitForExpectations(timeout: 6.0) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
}

