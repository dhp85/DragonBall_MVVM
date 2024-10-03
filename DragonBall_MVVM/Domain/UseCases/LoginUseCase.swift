

import Foundation

protocol LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginUseCase: LoginUseCaseContract {
    private let dataSource: SessionDataSourceContract
    
    init(dataSource: SessionDataSourceContract) {
        self.dataSource = dataSource
    }
    
    func execute(credentials: Credentials, completion: @escaping (Result<Void, any Error>) -> Void) {
        guard validateUsername(credentials.username) else {
            return completion(.failure(LoginUseCaseError(reason: "Usuario invalido")))
        }
        
        guard validatePassword(credentials.password) else {
            return completion(.failure(LoginUseCaseError(reason: "Contraseña invalida")))
        }
        
        LoginAPIRequest(credentials: credentials).perform { [weak self] result in
            switch result {
                case .success(let token):
                self?.dataSource.storeSession(token)
                completion(.success(()))
            case .failure:
                completion(.failure(LoginUseCaseError(reason: "Error de autenticación")))
            }
           
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

