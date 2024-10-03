

import Foundation

protocol LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginUseCase: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard validateUsername(credentials.username) else {
            return completion(.failure(LoginUseCaseError(reason: "Usuario invalido")))
        }
        
        guard validatePassword(credentials.password) else {
            return completion(.failure(LoginUseCaseError(reason: "Contraseña invalida")))
        }
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
            completion(.success(()))
        }
    }
    
    private func validateUsername(_ username: String) -> Bool {
        username.contains("@") && !username.isEmpty
    }
    
    private func validatePassword(_ password: String) -> Bool {
        password.count >= 4
    }
    
}

struct LoginUseCaseError: Error {
    let reason: String
}

