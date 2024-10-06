@testable import DragonBall_MVVM
import XCTest

private final class SuccesLoginUseCaseMock: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
        completion(.success(()))
    }
    
}

private final class FailLoginUseCaseMock: LoginUseCaseContract {
        func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
            completion(.failure(LoginUseCaseError(reason: "contraseña incorrecta")))
    }
}

final class LoginViewModelTests: XCTestCase {

    var sut: LoginViewModel!

    func testSignInSuccess() {
        // Inicializar el ViewModel con el mock de éxito
        let successUseCase = SuccesLoginUseCaseMock()
        sut = LoginViewModel(useCase: successUseCase)

        // Espera a que la llamada asíncrona complete
        let expectation = XCTestExpectation(description: "success")
        
        sut.onStateChanged.bind { state in
            if case .success = state {
                expectation.fulfill()
            }
        }
        
        sut.signIn("test@example.com", "123")
        
        // Espera a que la expectativa se cumpla
        wait(for: [expectation], timeout: 1.0)
    }

    func testSignInFailure() {
        // Inicializar el ViewModel con el mock de fallo
        let failUseCase = FailLoginUseCaseMock()
        sut = LoginViewModel(useCase: failUseCase)

        // Espera a que la llamada asíncrona complete
        let expectation = XCTestExpectation(description: "error")
        
        sut.onStateChanged.bind { state in
            if case .error(let reason) = state, reason == "contraseña incorrecta" {
                expectation.fulfill()
            }
        }
        
        sut.signIn("test@example.com", "wrongpassword")
        
        // Espera a que la expectativa se cumpla
        wait(for: [expectation], timeout: 1.0)
    }
}
