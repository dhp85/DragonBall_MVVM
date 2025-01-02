
@testable import DragonBall_MVVM
import XCTest

final class GetHeroDetailUseCaseTest: XCTestCase {
    
    func testSuccess() {
        guard let mockURL = Bundle(for: type(of: self)).url(forResource: "HeroDetailMock", withExtension: "json"),
              let data = try? Data(contentsOf: mockURL) else {
            return XCTFail("Mock can't be found")
        }
        let sut = GetHeroeDetailUseCase()
        let expectation = self.expectation(description: "TestSuccessToken")
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute(heroe: "Goku")  { result in
            guard case .success(let hero) = result else {
                return
            }
            XCTAssertEqual(hero?.name, "Goku")
            XCTAssertEqual(hero?.id, "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")
            XCTAssertEqual(hero?.photo, "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")
            XCTAssertEqual(hero?.description, "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.")
            XCTAssertTrue(hero?.favorite ?? false)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
    
    func testFailure() {
        let sut = GetHeroeDetailUseCase()
        let expectation = self.expectation(description: "TestFailure")
        APISession.shared = APISessionMock { request in
            return .failure(APIErrorResponse.unknown(""))
        }
        sut.execute(heroe: "Celula") { result in
            guard case .failure = result else {
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}
