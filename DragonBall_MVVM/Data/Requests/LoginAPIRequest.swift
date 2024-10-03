

import Foundation

//struct LoginAPIRequest: APIRequest  en el codigo del profesor no da fallo a mi si.
struct LoginAPIRequest: APIRequest {
    typealias Response = Data
     
    let headers: [String: String]
    let method: HTTPMethod = .POST
    let path: String = "/api/auth/login"
    
    init(credentials: Credentials) {
        let logindata = Data(String(format: "%@:%@", credentials.username, credentials.password).utf8)
        let base64String = logindata.base64EncodedString()
        headers = ["Authorization": "Basic \(base64String)"]
    }
    
}
