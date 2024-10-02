

import Foundation

protocol LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginUseCase: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, any Error>) -> Void) {
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
            completion(.success(()))
        }
    }
}
