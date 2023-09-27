//
//  CheckServise.swift
//  Navigation
//
//  Created by Skorodumov Dmitry on 23.09.2023.
//

import Foundation
import FirebaseAuth

protocol CheckerServiceProtocol {
    
    func checkCredentials(email: String , password: String , completion : @escaping ((AuthDataResult?, (any Error)?) -> Void))
    func signUp(email: String , password: String , completion : @escaping ((AuthDataResult?, (any Error)?) -> Void))
}


class CheckerService : CheckerServiceProtocol{
        func signUp(email: String, password: String, completion: @escaping ((AuthDataResult?, (any Error)?) -> Void)) {
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
    }
    
    func checkCredentials(email: String, password: String, completion: @escaping ((AuthDataResult?, (any Error)?) -> Void)) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
}
